char Twirlix(unsigned int i) {
	char t[] = ".-*";
	return t[i % (sizeof(t) - 1)];
}

typedef struct flake {
	unsigned int position;
	unsigned int speed;
	unsigned int angle;
} flake_t;

flake_t storm[20] = {
	{0, 1, 0},
	{0, 3, 0},
	{0, 5, 0},
	{0, 7, 0},
	{0, 9, 0},
	{0, 11, 0},
	{0, 8, 0},
	{0, 6, 0},
	{0, 4, 0},
	{0, 2, 0},
	{0, 9, 0},
	{0, 7, 0},
	{0, 5, 0},
	{0, 3, 0},
	{0, 1, 0},
	{0, 10, 0},
	{0, 8, 0},
	{0, 6, 0},
	{0, 4, 0},
	{0, 2, 0},
};

void snow (view_ptr view, viewport_ptr port) {
	int r, c;
	fputc(0x0C, &LCD.dev);
	for (r=0; r < LCD.h; r++) {
		for (c=0; c < LCD.w; c++) {
			storm[c].position += storm[c].speed;
			if (storm[c].position / 111 > LCD.h) storm[c].position = 0;
			if (storm[c].position / 111 != r) fputc(' ', &LCD.dev);
			else {
				fputc(Twirlix(storm[c].angle), &LCD.dev);
				storm[c].angle++;
			}
		}
		fputc('\n', &LCD.dev);
	}
	Disp_RC(1,2); fprintf(&LCD.dev, "Love me tender...\n");
}

void snowkey(view_ptr me, char key) {
	uint8_t temp;
	if (key==0) me->eject(me);
	//if (key==3) PORTL ^= 0x04;
	if (key==2) {
		// Save PWM and gate
		//temp = PORTL & 0x04;
		//PORTL &= 0xFF & 0x04;
		// IN A
		PORTL ^= 0x01;
		// IN B
		PORTD ^= 0x04;
		// Restore PWM
		//PORTL |= temp;
	}
}

view_ptr SnowFactory() {
	view_ptr v = (view_ptr) malloc(sizeof(view_t));
	if (v) {
		ViewConstruct(v, snow);
		v->key = snowkey;
	}
	return v;
}