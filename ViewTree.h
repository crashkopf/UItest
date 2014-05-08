/*
  View Tree - Maintains the UI tree, is constructed of vtnodes.  This allows for automatic 
  construction of hierarchical menus.  If a vtnode has a view then that view is
  displayed.  It it has children, but no view, a menu is created.
*/

// typedef struct vtnode * vtnode_ptr;
// typedef struct viewtree * viewtree_ptr;

// typedef struct vtnode {
	// menuitem_t menuitem;
	// view_ptr view;
	// vtnode_ptr parent;
	// vtnode_ptr * children;
// } vtnode_t;

#ifdef __cplusplus
extern "C" {
#endif

// vtnode_ptr VTNodeConstruct(vtnode_ptr node, view_ptr view, vtnode_ptr parent, vtnode_ptr * children, const char * label);
// vtnode_ptr VTGetRoot(viewtree_ptr tree);
// vtnode_ptr VTGetCurrent(viewtree_ptr tree);
// void VTSetRoot(viewtree_ptr tree, vtnode_ptr node);
// void VTSetCurrent(viewtree_ptr tree, vtnode_ptr node);

// void VTMenuSelect(menu_ptr menu, unsigned int item);
// void VTMenuExit(view_ptr menu);

#ifdef __cplusplus
}
#endif