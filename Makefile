GETH=geth --dev
GENESISJSON=genesis.json
GETHB1=E1
GETHB2=E2
B1_FLAGS=
B2_FLAGS=
CONFIG1=-config=$(D1)/config.toml $(B1_FLAGS)
CONFIG2=-config=$(D2)/config.toml $(B2_FLAGS)
DATADIR1=--datadir=$(GETHB1)
DATADIR2=--datadir=$(GETHB2)

setup:
	$(GETH) init $(DATADIR1) $(GENESISJSON) --networkid 123 --nodiscover --maxpeer
	$(GETH) init $(DATADIR2) $(GENESISJSON) --networkid 123 --nodiscover --maxpeer

clean:
	rm -rf $(GETHB1) && mkdir $(GETHB1)
	rm -rf $(GETHB2) && mkdir $(GETHB2)

createwallet1:
	$(GETH) $(DATADIR1) account new

createwallet2:
	$(BITCOINCLI) $(B2) createwallet $(WALLETNAME)

# BITCOIN-CLI 
start:
	$(BITCOIND) $(B1) -daemon
	$(BITCOIND) $(B2) -daemon

start-prune:
	prune=1 $(BITCOIND) $(B1) -daemon
	prune=1 $(BITCOIND) $(B2) -daemon

start-gui:
	$(BITCOINGUI) $(B1) &
	$(BITCOINGUI) $(B2) &

generate:
	$(BITCOINCLI) $(B1) -generate $(BLOCKS)

getinfo:
	$(BITCOINCLI) $(B1) -getinfo
	$(BITCOINCLI) $(B2) -getinfo

sendfrom1:
	$(BITCOINCLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(BITCOINCLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(BITCOINCLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(BITCOINCLI) $(B2) getnewaddress $(ACCOUNT)

stop:
	$(BITCOINCLI) $(B1) stop
	$(BITCOINCLI) $(B2) stop

command1:
	$(BITCOINCLI) $(B1) $(C)
command2:
	$(BITCOINCLI) $(B2) $(C)
