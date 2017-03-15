#include <iostream>
#include <cmath>
#include <string.h>
using namespace std;

const int maxn = 31;
int a[maxn][maxn];  //增广矩阵
int x[maxn];        //解集
bool freeX[maxn];   //标记解是否是自由变元

//高斯消元解方程组
//返回值-2表示有浮点数解，无整数解
//返回值-1表示无解，0表示有唯一解，大于0表示有无穷解，返回自由变元个数
//有equ个方程，var个变元
//增广矩阵行数[0, equ - 1]
//增广矩阵列数[0, var]
int gauss(int equ, int var)
{
    for (int i = 0; i <= var; i++)
    {
        x[i] = 0;
        freeX[i] = true;
    }
    //转换为阶梯矩阵
    //col表示当前正在处理的这一列
    int col = 0;
    int row = 0;
    //maxR表示当前这个列中元素绝对值最大的行
    int maxRow;
    for (; row < equ && col < var; row++, col++)
    {
        //枚举当前正在处理的行
        //找到该col列元素绝对值最大的那行与第k行交换
        maxRow = row;
        for (int i = row + 1; i < equ; i++)
        {
            if (abs(a[maxRow][col]) < abs(a[i][col]))
            {
                maxRow = i;
            }
        }
        if (maxRow != row)
        {
            //与第row行交换
            for (int j = row; j < var + 1; j++)
            {
                swap(a[row][j], a[maxRow][j]);
            }
        }
        if (a[row][col] == 0)
        {
            //说明该col列第row行以下全是0，处理当前行的下一列
            row--;
            continue;
        }
        for (int i = row + 1; i < equ; i++)
        {
            //枚举要删的行
            if (a[i][col] != 0)
            {
                for (int j = col; j < var + 1; j++)
                {
                    a[i][j] ^= a[row][j];
                }
            }
        }
    }
    for (int i = var - 1; i >= 0; i--)
    {
        x[i] = a[i][var];
        for (int j = i + 1; j < var; j++)
        {
            x[i] ^= (a[i][j] && x[j]);
        }
    }
    return 0;
}

int main()
{
	int n;
	cin >> n;
	for (int i = 0; i < n; ++i)
	{
		memset(a, 0, sizeof(a));

		for (int i = 0; i < 30; i++)
            cin >> a[i][30];

        for (int i = 0; i < 5; i++)
        {
            for (int j = 0; j < 6; j++)
            {
                int t = i * 6 + j;
                a[t][t] = 1;
                if(i>0)
                	a[(i-1)*6+j][t]=1;
                if(i<4)
                	a[(i+1)*6+j][t]=1;
                if(j>0)
                	a[i*6+j-1][t]=1;
                if(j<5)
                	a[i*6+j+1][t]=1;
            }
        }

        gauss(30, 30);
        cout << "PUZZLE #" << i+1 << endl;
        for(int i = 0; i < 30; i++)
        {
            cout << x[i];
            if((i+1) % 6 == 0)
                cout << endl;
            else
                cout << " ";
        }
	}
}