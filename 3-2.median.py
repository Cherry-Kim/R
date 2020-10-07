import string,sys,numpy,glob

fp=glob.glob('*.t.txt')
for fname in fp:
	fp1=open(fname,'r')
	TPM=[]	#value initialization
	TPM_N=[]
	sample = fname.split('.t.txt')[0]
	hd=fp1.readline()
	for line in fp1:
		line_temp=line[:-1].split('\t')
		if 'T' == line_temp[0]:
			TPM.append(float(line_temp[1]))
		elif 'N' == line_temp[0]:
			TPM_N.append(float(line_temp[1]))
#	print TPM
#	print TPM_N

	X = numpy.array(TPM)
	Z = numpy.median(X)
	Y = numpy.min(X)
	K = numpy.max(X)
	print sample, '_T',' : median = ', Z
	print  'T',' : min = ', Y
	print  'T',' : max = ', K

	a = numpy.array(TPM_N)
	b = numpy.median(a)
	c = numpy.min(a)
	d = numpy.max(a)
	print sample, '_N',' : median = ', b
	print 'N',' : min = ', c
	print 'N',' : max = ', d
