library('RUnit')
testsuite.all = defineTestSuite("All", dirs = c(file.path(getwd(),"Scripts","crowdMovement","testUnits","util"), file.path(getwd(),"Scripts","crowdMovement","testUnits","algorithms")))

testResult <- runTestSuite(testsuite.all)
printTextProtocol(testResult)

rm(testResult)
rm(testsuite.all)
rm(list = lsf.str())