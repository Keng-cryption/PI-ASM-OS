#include "calc.h"

// Simple integer calculator
int calc(int a, int b, char op) {
    switch (op) {
        case '+': return a + b;
        case '-': return a - b;
        case '*': return a * b;
        case '/': 
            if (b == 0) return 0; // avoid divide by zero
            return a / b;
        default: return 0;
    }
}
