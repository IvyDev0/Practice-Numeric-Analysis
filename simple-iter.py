import matplotlib.pyplot as plt

def Iteration(f, section, x0, maxiter, e): 
    
    # 此处略去几行画图的代码
    
    x1 = f(x0)
    c = 1
    print ('x0: {0}'.format(x0))
    while c<maxiter and abs(x0-x1)>e:
        print ('x{0}: {1}'.format(c,x1)) # 打印解
        #plt.scatter(x0,f(x0), 5, color ='red')        
        x0 = x1
        
        try:
            x1 = f(x0) # 迭代
        except Exception as err: 
            print(err) # 若迭代不收敛则x值会越来越大而溢出
            print("Not Convergence")
            return
        finally:
            c+=1

    #plt.show()    
    if c==maxiter:
        print("Not Convergence")


import warnings
# 捕捉所有溢出的错误
warnings.simplefilter("error", RuntimeWarning)
    
def IfConvergence(f, X0, maxiter, e):
    for x0 in X0:
        flag = 0
        print('x0={0}, '.format(x0), end='') 
        
        try:
            x1 = f(x0) 
        except Exception as err: 
            print(err, end='') 
            print(', inappropriate x0:{0}'.format(x0))
            break
            
        c = 1
        while c<maxiter and abs(x0-x1)>e:       
            x0 = x1
            try:
                x1 = f(x0) # 迭代
            except Exception as err: 
                print(err, end='') # 若迭代不收敛则x值会越来越大而溢出
                flag = 1
                break
            finally:
                c+=1 
                
        if c<maxiter and flag==0:
            print('convergence to x{0}={1}'.format(c-1,x1))
        else:
            print(', not convergence')



if __name__ == '__main__':
    y1 = lambda x: (3*x+1)/x**2
    x = np.linspace(-5,5)
    IfConvergence(y1, x, 50, 10**(-5))

    x = np.linspace(-3,-0.3)
    Iteration(y1, x, -3, 50, 10**(-5))



    y2 = lambda x: (x**3-1)/3
    x = np.linspace(-3,3)
    IfConvergence(y2, x, 50, 10**(-5))

    x = np.linspace(-1.5,0)
    Iteration(f, x, -1.2, 50, 10**(-5))


    y3 = lambda x: sqrt(3+(1/x))
    x1 = np.linspace(-2,-1./3)
    x2 = np.linspace(0.01,2)
    IfConvergence(y3, x1, 50, 10**(-5))
    IfConvergence(y3, x2, 50, 10**(-5))

    x = np.linspace(0,4)
    Iteration(f, x, 0.1, 50, 10**(-5))





