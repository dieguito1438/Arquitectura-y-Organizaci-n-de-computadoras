#include <stdio.h>
#include <string.h>


typedef struct {
  char name[10];  
  int rd;         
  int rs;         
  int rt;      
  int inmediato;
} Instruction;


int regs[16];       
float fregs[8];     
double dregs[8];    

int memoria[256];
Instruction mem_Ins[100]; 
int num_instrucciones = 0;     

int PC = 0;

void ejecucion() {
  PC = 0;
  while (PC < num_instrucciones) {
    Instruction inst = mem_Ins[PC];
    PC++;   

        
    if (strcmp(inst.name, "ADD") == 0) {

      regs[inst.rd] = regs[inst.rs] + regs[inst.rt];
    }
    else if (strcmp(inst.name, "AND") == 0) {

      regs[inst.rd] = regs[inst.rs] & regs[inst.rt];
    }
    else if(strcmp(inst.name, "SUB") == 0){
      regs[inst.rd] = regs[inst.rs] - regs[inst.rt];
    }
    else if(strcmp(inst.name, "OR") == 0){
      regs[inst.rd] = regs[inst.rs] | regs[inst.rt];
    }
    else if(strcmp(inst.name, "XOR") == 0){
      regs[inst.rd] = regs[inst.rs] ^ regs[inst.rt];
    }
    else if(strcmp(inst.name, "MUL") == 0){
      regs[inst.rd] = regs[inst.rs] * regs[inst.rt];
    }
    else if(strcmp(inst.name, "DIV") == 0){
      regs[inst.rd] = regs[inst.rs] / regs[inst.rt];
    }
    else if(strcmp(inst.name, "ADDI") == 0){
      regs[inst.rd] = regs[inst.rs] + inst.inmediato;
      
    }
    //---------------------------------------------------
    else if(strcmp(inst.name, "LI") == 0){
      regs[inst.rd] = inst.inmediato;
       
    }
    
    else if(strcmp(inst.name, "LA") == 0){
      regs[inst.rd] = inst.inmediato; // pero para direccion
    }
    
    else if(strcmp(inst.name, "LW") == 0){
      int direccion = regs[inst.rs] + inst.inmediato;
      int valor = memoria[direccion];
      regs[inst.rd] = valor;
    }
    else if(strcmp(inst.name, "SW") == 0){
      int direccion = regs[inst.rs] + inst.inmediato;
      memoria[direccion] = regs[inst.rt];
      
    }
    //---------------------------------------------------
    else if(strcmp(inst.name, "FADD") == 0){
      fregs[inst.rd] = fregs[inst.rs] + fregs[inst.rt];
       
    }
    
    else if(strcmp(inst.name, "FSUB") == 0){
      fregs[inst.rd] = fregs[inst.rs] - fregs[inst.rt];
    }
    
    else if(strcmp(inst.name, "DADD") == 0){
      dregs[inst.rd] = dregs[inst.rs] + dregs[inst.rt];
    }
    else if(strcmp(inst.name, "DSUB") == 0){
      dregs[inst.rd] = dregs[inst.rs] - dregs[inst.rt];
      
    }
    //-------------------------------------------------
    else if(strcmp(inst.name, "J") == 0){
      PC = inst.inmediato;
       
    }
    
    else if(strcmp(inst.name, "BEQ") == 0){
      if(regs[inst.rs] == regs[inst.rt]){
	PC = inst.inmediato;
      }
    }
    
    else if(strcmp(inst.name, "PRINT") == 0){
      printf("%d\n", regs[inst.rd]);
    }
    //-------------------- Extras para poder imprimir y cargar enteros y dobles
    
    
    else if(strcmp(inst.name, "PRINTF") == 0){
      printf("%f\n", fregs[inst.rd]);
    }
    else if(strcmp(inst.name, "PRINTD") == 0){
      printf("%lf\n", dregs[inst.rd]);
    }

  }
}
//--------------metodos auxiliares-------------------------
void limpia() {
  for (int i = 0; i < 16; i++)
    regs[i] = 0;
  for (int i = 0; i < 8; i++) {
    fregs[i] = 0.0;
    dregs[i] = 0.0;
  }
  for (int i = 0; i < 256; i++) memoria[i] = 0;
  PC = 0;
  num_instrucciones = 0;
    
}
void finalizacion(Instruction programa[], int num){
  for (int i = 0; i < num; i++) mem_Ins[i] = programa[i];
  num_instrucciones = num;
  ejecucion();
}
//-------------------Pruebas-----------------------------------------
void loop(){

  limpia();
  Instruction prueba2[] = {
        {"LI", 1, 0, 0, 0},     
        {"LI", 2, 0, 0, 10},   
        {"PRINT", 1, 0, 0, 0}, 
        {"ADDI", 1, 1, 0, 1},  
        {"BEQ", 0, 1, 2, 6},    
        {"J", 0, 0, 0, 2},     
        {"PRINT", 1, 0, 0, 0}, 

  };
  int num = sizeof(prueba2) / sizeof(Instruction);
  finalizacion(prueba2, num);

}
void malicioso(){
  limpia();
  Instruction prueba3[] = {
        {"J", 0, 0, 0, 3},     
        {"J", 0, 0, 0, 500},    
        {"PRINT", 1, 0, 0, 0},
        {"LI", 1, 0, 0, 666},  
        {"PRINT", 1, 0, 0, 0},  
    };
  int num = sizeof(prueba3) / sizeof(Instruction);
  finalizacion(prueba3,num);
}


//-------------------------------------------------------------------
int main(int argc, char *argv[]){
  
  /* Simulamos instrucciones LIF y LID para mantener int en el inmediato.
     Asi evitando los errores de punto flotante */
  fregs[0] = 5.5;
  fregs[1] = 3.3;
  dregs[0] = 5.5;
  dregs[1] = 3.3;
  //--------------------------------------------------------------------
  
  Instruction prueba[] = {
    {"LI", 1, 0, 0, 5},
    {"LI", 2, 0, 0, 3},
    {"AND", 3, 1, 2, 0},
    {"PRINT", 3, 0, 0, 0},
    {"ADD", 3,1,2,0},
    {"PRINT", 3, 0, 0, 0},
    {"SUB", 3, 1, 2, 0},
    {"PRINT", 3, 0, 0, 0},
    {"OR", 3, 1, 2, 0},
    {"PRINT", 3, 0, 0, 0},
    {"XOR", 3, 1, 2, 0},
    {"PRINT", 3, 0, 0, 0},
    {"MUL", 3, 1, 2, 0},
    {"PRINT", 3, 0, 0, 0},
    {"DIV", 3, 1,2,0},
    {"PRINT", 3, 0, 0, 0},
    {"ADDI", 3, 1, 0 , 7},
    {"PRINT", 3, 0, 0, 0},
    //--------------------------
    {"LA", 4, 0, 0, 100},
    {"LI", 5, 0, 0, 42},
    {"SW", 0, 4, 5, 0},
    {"LW", 6, 4, 0, 0},
    {"PRINT", 6, 0, 0, 0},

    //--------------------------

    {"FADD", 3,0,1,0},
    {"PRINTF", 3, 0, 0, 0},
    {"FSUB", 3, 0, 1, 0},
    {"PRINTF", 3, 0, 0, 0},

    {"DADD", 3,0,1,0},
    {"PRINTD", 3, 0, 0, 0},
    {"DSUB", 3, 0, 1, 0},
    {"PRINTD", 3, 0, 0, 0},

  };
  int num = sizeof(prueba) / sizeof(Instruction);
  finalizacion(prueba,num);
  loop();
  malicioso();
}
