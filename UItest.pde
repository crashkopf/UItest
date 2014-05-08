#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <avr/pgmspace.h>

#include <display.h>
#include <keypad.h>

#include <view.h>
#include <tree.h>
#include <menu.h>
#include <dialog.h>

viewport_t LCD;
viewmux_t vmux;
menunode_s mainmenu[16];
menunode_p root, current, more;

int Disp_putc(char c, FILE * f) {
	switch (c) {
		case (0x0A):	// Line feed
			Disp_RC(++LCD.row, 0);
			break;
		case (0x0C):	// Form feed
			Disp_Clear();
			Disp_RC(0,0);
			LCD.row=0; LCD.col=0;
			break;
		case (0x0D):	// Carriage return
			Disp_RC(LCD.row, 0);
			break;
		default:
			Disp_PutChar(c);
			break;
	}
	return 0;
}

int GetKey (FILE * file) {
	return Kpd_GetKeyAsync();
}

void DoDisplay() {
	VmuxTick(&vmux);
}

void DoHeartBeat() {
	DDRJ ^= 0x80;
	PORTJ ^= 0x80;    // toggle the heartbeat LED
}

void MySelect (menu_ptr menu, menunode_p node){
	Serial.print("Node selected: "); 
	Serial.print((unsigned int) current); 
	Serial.print(" -> "); 
	Serial.print((unsigned int) node);
	Serial.println();
	if (node) current = node;
	VmuxSwitch(&vmux, 0);
}
view_ptr MyAccept (viewmux_ptr mux) {
	if (current->factory) {
		Serial.println("Factory View Accepted!");
		return current->factory();
	}
	else {
		menu_ptr menu = (menu_ptr) malloc(sizeof(menu_t));
		Serial.print("Allocated ");
		Serial.print(sizeof(menu_t));
		Serial.print(" at ");
		Serial.println((unsigned int)menu);
		if (menu) {
			MenuConstruct(menu, current, MySelect);
		}
		Serial.println("Menu View Accepted!");
		return (view_ptr) menu;
	}
}
void MyEject(viewmux_ptr me, view_ptr view) {
	VmuxDefaultEjectFunc(me, view);
	Serial.print("View Ejected, current node: ");
	Serial.print((unsigned int) current);
	Serial.print(" -> ");
	if (view) {
		free(view);
		if (current && current->node.parent) 
			current = (menunode_p) current->node.parent;
	} 
	Serial.print((unsigned int) current);
	Serial.println();
}

void setup() {
	Serial.begin(9600);
	Disp_Init();
	Kpd_Init();
	Disp_Reset();
	Kpd_Reset();
	
	// viewport / viewmux setup
	LCD.w = 20;
	LCD.h = 4;
	fdev_setup_stream(&LCD.dev, Disp_putc, GetKey, _FDEV_SETUP_RW);
	VmuxConstruct(&vmux, &LCD);
	vmux.accept = MyAccept;
	vmux.eject = MyEject;
	
	root = &mainmenu[0];
	current = root;
	
	int i;
	MenunodeConstruct(&mainmenu[i++], PSTR("Holidays"), 0);
	
	MenunodeConstruct(&mainmenu[i], PSTR("Celebrate!"), SnowFactory);
	NodeAppend((node_p)root, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("More..."), 0);
	NodeAppend((node_p)root, (node_p) (more = &mainmenu[i++]));
	
	MenunodeConstruct(&mainmenu[i], PSTR("Valentines Day"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("Easter"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("4th of July"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("Halloween"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("Thanksgiving"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("Christmas Eve"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
	MenunodeConstruct(&mainmenu[i], PSTR("Christmas"), 0);
	NodeAppend((node_p)more, (node_p)&mainmenu[i++]);
}

void loop() {
	while(1) {
		DoHeartBeat();
		ViewSetUpdate(vmux.current); // Force update
		DoDisplay();
		delay(100);
	}
}