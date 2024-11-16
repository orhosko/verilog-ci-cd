#include "Vour.h"
#include "verilated.h"

auto main(int argc, char **argv) -> int {
    auto *contextp = new VerilatedContext;
    contextp->commandArgs(argc, argv);
    Vour *top = new Vour{contextp};
    while (!contextp->gotFinish()) {
        top->eval();
    }
    delete top;
    delete contextp;
    return 0;
}
