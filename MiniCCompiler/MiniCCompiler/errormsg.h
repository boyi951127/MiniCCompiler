#pragma once
#include <string>
#define TRUE 1
#define FALSE 0
using namespace std;

extern int EM_tokPos;
extern bool EM_anyErrors;

void EM_newline(void);
void EM_error(int, string, ...);
void EM_impossible(string, ...);
void EM_reset(string filename);