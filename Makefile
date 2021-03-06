SRC=HBot
CSRC=Config/config.c
PLUGINNAMES=Admin Wikla Unicafe Random Random3 Lanit Arabianranta Util/Random Util/DatabasePath UrlAnalyzer Help Logger Trivia DogeTip Give Btc TeamTapiiri
PLUGINS=$(addprefix Plugin/,$(PLUGINNAMES))
PLUGINOBJECTS=$(addsuffix .o,$(PLUGINS))
COBJECTS=$(CSRC:.c=.o)

all: $(COBJECTS) plugins
	-rm Config.o
	ghc -package ghc -package ghc-paths $(SRC) $(COBJECTS)
	ld -r Config/config.o Config.o -o Config.tmp.o
	mv Config.tmp.o Config.o

plugins:
	ghc $(PLUGINS)

%.o: %.c %.h
	gcc -c -D_GNU_SOURCE -std=c99 $< -o $@

clean:
	-rm *.hi *.o Config/*.hi Config/*.o Plugin/*.hi Plugin/*.o
	-rm HBot

.PHONY: all clean
