def sout = new StringBuilder(), serr = new StringBuilder()
def proc = 'aws s3 ls s3://ot-microservices/Employee/'.execute()
proc.consumeProcessOutput(sout, serr)
proc.waitForOrKill(2000)
def values = "$sout".split('/')
def trimmedValues
def parameters=[]
values.each {  println "${it}" }
def cleanValues = "$sout".split('PRE')
def last = cleanValues.last().split('/')[1]
cleanValues.each {  "${it}".toString(); 
                    trimmedValues = "${it}".trim();
                    parameters<<trimmedValues
 }
parameters.add(last)
parameters
