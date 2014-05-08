// menu_t tempMenu;
// viewtree_t tree;

// vtnode_ptr VTNodeConstruct(vtnode_ptr node, view_ptr view, vtnode_ptr parent, vtnode_ptr * children, const char * label) {
	// MenuitemConstruct((menuitem_ptr)node, label);
	// node->view = view;
	// node->parent = parent;
	// node->children = children;
	// return node;
// }

// vtnode_ptr VTGetRoot(viewtree_ptr tree){return tree->root;}
// vtnode_ptr VTGetCurrent(viewtree_ptr tree){return tree->current;}
// void VTSetRoot(viewtree_ptr tree, vtnode_ptr node){tree->root = node;}
// void VTSetCurrent(viewtree_ptr tree, vtnode_ptr node){tree->current = node;}

// void VTNodeEnter(viewmux_ptr mux, vtnode_ptr node) {
	// if (node->view) VmuxSwitch(mux, node->view);
	// else if (node->children) {
		// MenuConstruct (&tempMenu, (menuitem_ptr *) node->children, VTMenuSelect);
		// tempMenu.view.mux = mux;
		// tempMenu.view.eject = VTMenuExit;
		// VTSetCurrent(&tree, node);
		// VmuxSwitch(mux, (view_ptr) &tempMenu);
	// }
	//Exception: If we couldn't make a valid selection, do nothing.
// }
// void VTNodeExit(viewmux_ptr mux, vtnode_ptr node) {

// }

// void VTMenuSelect(menu_ptr menu, unsigned int item) {
	// VTNodeEnter(menu->view.mux, (vtnode_ptr) menu->items[item]);
// }

// void VTMenuExit(view_ptr menu) {
// }