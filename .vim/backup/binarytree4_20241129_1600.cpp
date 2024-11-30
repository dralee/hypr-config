/**
 * binary tree height
 * delete a specific element
 * 2024.11.29
 */
#include <bits/stdc++.h>
#include <queue>
using namespace std;

class Node{
public:
	int data;
	Node *left;
	Node *right;

	Node(int val){
		data = val;
		left = nullptr;
		right = nullptr;
	}
};

// delete the deepest node in binary tree
void deleteDeepest(Node* root, Node *dNode){
	queue<Node*> q;
	q.push(root);

	Node *current;
}

// inorder traversal of a binary tree
void inorder(Node* current){
	if(current == nullptr){
		return;
	}

	inorder(current->left);
	cout<< current->data << ' ';
	inorder(current->right);
}

int main(int argc, char **argv){
	// Representation of the input tree:
	//     1
	//    / \
	//   2   3
	//  /   / \
	// 4   5   6

	Node *root = new Node(1);
	root->left = new Node(2);
	root->right = new Node(3);
	root->left->left = new Node(4);
	root->right->left = new Node(5);
	root->right->right = new Node(6);

	inorder(root);

	return 0;
}
