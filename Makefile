GETHB1=E1
GETHB2=E2
B1_FLAGS=
B2_FLAGS=
CONFIG1=-config=$(D1)/config.toml $(B1_FLAGS)
CONFIG2=-config=$(D2)/config.toml $(B2_FLAGS)
DATADIR1=--datadir=$(GETHB1)
DATADIR2=--datadir=$(GETHB2)
ARG=

setup:
	geth $(DATADIR1) init ./genesis.json
	geth $(DATADIR2) init ./genesis.json

startconsole1:
	geth $(DATADIR1) --networkid 1114 console 2>> eth.log

startconsole2:
	geth $(DATADIR2) --networkid 1114 console 2>> eth.log

startattach1:
	geth $(DATADIR1) --networkid 1114 attach --exec "eth.blockNumber"

startattach2:
	geth $(DATADIR2) --networkid 1114 attach --exec "eth.blockNumber"


createwallet1:
	echo $(PSWD) >> pswd && geth --datadir=$(DATADIR1) --verbosity=1 account new --password pswd | grep "0x.{0,40}" -o -E
	
createwallet2:
	echo $(PSWD) >> pswd && geth --datadir=$(DATADIR2) --verbosity=1 account new --password pswd | grep "0x.{0,40}" -o -E
	rm pswd

clean:
	rm -rf $(GETHB1) && mkdir $(GETHB1)
	rm -rf $(GETHB2) && mkdir $(GETHB2)
	rm eth.log