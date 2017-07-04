//
//  fileTool.c
//  TestC
//
//  Created by WangShuChao on 2017/7/3.
//  Copyright © 2017年 GuoChao. All rights reserved.
//

#include "fileTool.h"
#include "string.h"
#include <stdlib.h>

int charLn(const char *content);
int getFileSize(const char *fileName);
//创建文件
int createFile(const char *fileName, const char *content){

    int  results = -1;
    
    FILE *fp = NULL;
    fp = fopen(fileName, "w");
    if(fp != NULL)results = 1;
    if (content != NULL && fp != NULL) {
        //向文件写内容
        //strlen(content) 内容的长度
        //sizeof(char) 一个字符的长度
        
        //向文件 写入 content  ，总长度(sizeof(char) * strlen(content)) 写1次
//        fwrite(content, (sizeof(char) * strlen(content)), 1, fp);
        
        //向文件 写入 content  ，总长度sizeof(char) 写strlen(content)次
        fwrite(content, sizeof(char), strlen(content), fp);
        results = 1;
    }
    fclose(fp);
    return results;
}
//计算char 的长度
int charLn(const char *content){
    int ln = 0;
    while (content++ != '\0') {
        ln += 1;
    }
    return ln;
}

//读文件内容
int readFileContent(const char *fileName){
    
    FILE *fp = NULL;
    fp = fopen(fileName, "rt+");
    if (fp == NULL) return 0;
    int num = getFileSize(fileName);
    char buf[num];
    char ch;
    int i = 0;
    while ((ch=fgetc(fp))!=EOF) {
        buf[i] = ch;
        i++;
    }
    fclose(fp);
    char a[1024] = {'s','a','y',' '};
    int j = 0;
    int k = 4;
    // 往 a 数组里加 字符
    while (buf[j] != '\0') {
        a[k] = buf[j];
        j++;
        k++;
    }
    //传个 以 “say ”开头的就可以让机器出声了
    system(a);
    return 1;
}

//文件大小
int getFileSize(const char *fileName){

    FILE *fp = NULL;
    fp = fopen(fileName, "rt+");
    if (fp == NULL) return 0;
    fseek(fp, 0L, SEEK_END);
    long size = ftell(fp);
    fclose(fp);
    int num = (int)size+1;
    return num;
}


