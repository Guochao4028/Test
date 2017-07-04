#include "stdio.h"


#include "fileTool.h"
//文件操作
void fileOption();


int main(){
//    fileOption();
    return 0;
}

void fileOption(){

    //创建文件
    int isSuccess =  createFile("/Users/Thirteen/Desktop/GitWorkSpace/test/TestC/TestC/test.txt", "寥落古行宫,宫花寂寞红,白头宫女在,闲坐说玄宗");//    寥落古行宫,宫花寂寞红,白头宫女在,闲坐说玄宗
    if(isSuccess != -1){
        //读取文件内容
        int isRead = readFileContent("/Users/Thirteen/Desktop/GitWorkSpace/test/TestC/TestC/test.txt");
        if (isRead == 0) {
            printf("读文件内容失败");
        }
    }else{
        printf("创建文件失败");
    }
}







