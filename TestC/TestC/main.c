#include "stdio.h"
#include <stdlib.h>

#include "fileTool.h"


void readingFile();

int main(){
    
    

    int isSuccess =  createFile("/Users/Thirteen/Desktop/GitWorkSpace/test/TestC/TestC/test.txt", "i am king");
//    寥落古行宫,宫花寂寞红,白头宫女在,闲坐说玄宗
    if(isSuccess != -1){
    
        readFileContent("/Users/Thirteen/Desktop/GitWorkSpace/test/TestC/TestC/test.txt");
        
    }else{
    
        printf("创建文件失败");
    }
    
////    
//    char a[] = "say a";
//    system(a);
    
    return 0;
}

void readingFile();





