import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

def loadData(filename):
	data = pd.read_excel(filename)
	data1 = data[data.iloc[:,1]<=2].values
	data1[:,1] = data1[:,1] - 1
	return data1[:,[1,6,7]].astype(float) # 仅使用两个类别的平均年龄和年龄差属性
	# return data1[:,1:].astype(float) # 使用两个类别所有属性

def normalization(X):
	Xmin = np.min(X, axis=0)
	Xmax = np.max(X, axis=0)
	Xmu = np.mean(X, axis=0)
	X_norm = (X - Xmu) / (Xmax - Xmin)
	return X_norm

def sigmoid(wx):
	sigmoidV = 1.0/(1.0+np.exp(-wx))
	return sigmoidV

def loss(X, Y, w):
	m, n = np.shape(X)
	trainMat = np.mat(X)
	Y_ = []
	for i in np.arange(m):
		Y_.append(sigmoid(trainMat[i]*w))
	m = np.shape(Y_)[0]
	sum_err = 0.0
	for i in range(m): 
		sum_err -= Y[i]*np.log(Y_[i])+(1-Y[i])*np.log(1-Y_[i])
	return (sum_err/m)[0,0]

def BGD(X, y, iter_num, alpha):
	trainMat = np.mat(X)
	trainY = np.mat(y).T
	m, n =np.shape(X)
	w = np.ones((n,1))
	trainloss = []
	trainacc = []
	for i in range(iter_num):
		wx = trainMat*w
		wx = np.array(wx, dtype=np.float32)
		error = sigmoid(wx)-trainY
		w = w - (1.0 / m) * alpha * trainMat.T * error
		trainloss.append(loss(X, y, w))
		trainacc.append(precision(X, y, w))

	return w, trainloss, trainacc

def classify(wx):
	prob = sigmoid(wx)
	return 1 if prob > 0.5 else 0

def predict(testX, w):
	m, n = np.shape(testX)
	testMat = np.mat(testX)
	result = []
	for i in np.arange(m):
		result.append(classify(float(testMat[i]*w)))

	return result

def precision(X, Y, w):
	result = predict(X, w)
	right_sum = 0
	for i in range(len(result)):
		if result[i] - int(Y[i]) == 0:
			right_sum += 1
	return 1.0 * right_sum / len(Y)

def plotDecisionBoundary(trainX, trainY, w, iter_num = 0):
    xcord1 = [];ycord1 = [];xcord2 = [];ycord2 = [] 
    m, n = np.shape(trainX)                         
    for i in range(m):                              
        if trainY[i] == 1:                          
            xcord1.append(trainX[i,1])              
            ycord1.append(trainX[i,2])              
        else:                                       
            xcord2.append(trainX[i,1])              
            ycord2.append(trainX[i,2])              
    x_min = min(trainX[:,1])                        
    y_min = min(trainX[:,2])                       
    x_max = max(trainX[:,1])                 
    y_max = max(trainX[:,2])

    
    fig = plt.figure(1) 
    plt.scatter(xcord1, ycord1, s=30, c='red', marker='s', label='categroy1')
    plt.scatter(xcord2, ycord2, s=30, c='green', marker='o', label="categroy2")
    
    plt.legend(loc='upper right')                   

    
    delta_x = x_max-x_min 
    delta_y = y_max-y_min 
    
    my_x_ticks = np.arange(x_min - delta_x / 10, x_max + delta_x / 10, 1)
    
    my_y_ticks = np.arange(y_min - delta_y / 10, y_max + delta_y / 10, 1)

    plt.xticks(my_x_ticks)                          
    plt.yticks(my_y_ticks)                          
    
    plt.axis([x_min-delta_x/10, x_max+delta_x/10, y_min-delta_y/10, y_max+delta_y/10])

    
    x = np.arange(x_min-delta_x/10, x_max+delta_x/10, 0.01) 
    y = (-w[0]-w[1]*x)/w[2]
    plt.plot(x, y.T)                                                         
    plt.show(fig)                                  

if __name__ == '__main__':
	data = loadData("data.xlsx")
	X = data[:,1:]
	y = data[:,0]
	X_norm = normalization(X)
	iter_num = 3000
	lr = 0.1
	m,n = np.shape(data)
	offset = np.ones((m,1))
	trainMat = np.c_[offset, X_norm]
	theta, trainloss, trainacc = BGD(trainMat, y, iter_num, lr)
	cost = loss(trainMat, y, theta)
	print("Cost is {}".format(cost))
	p = precision(trainMat, y, theta)
	print("accuracy is {}".format(p))

	x = range(iter_num)
	fig = plt.figure()
	ax1 = fig.add_subplot(111)
	ax1.plot(x, trainacc, label='training accuracy')
	ax1.set_xlabel('iteration num')
	ax1.set_ylabel('training accuracy!')
	ax1.legend(loc=1)

	ax2 = ax1.twinx()  # this is the important function
	ax2.plot(x, trainloss, 'r', label='training loss')
	ax2.set_ylabel('training loss')
	ax2.set_xlabel('iteration num')
	ax2.legend(loc=2)
	plt.show()

	plotDecisionBoundary(trainMat, y, theta) # 使用全部属性时注释掉这句
	plt.show()








