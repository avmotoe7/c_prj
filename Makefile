#-----------------------------------------------------------------
# Podrazumeva se da u projektnom direktorijumu postoje
# poddirektorijumi: src, include, lib, lib/src i lib/include
# Make pravi build direktorijum gde smesta objektne fajlove, 
# kao i bin i lib/bin gde smesta izvrsne fajlove i biblioteke.
# Sa make <all pravi> se i staticka i dinamicka verzija programa
# staticka i dinamicka biblioteka smestaju se u lib/bin
# 
# Novi fajlovi se dodaju rucno, ostalo u Makefile se ne dira.
#-----------------------------------------------------------------

# Dodaj nove fajlove rucno.
PRG_SRC = src/main.c src/ispis.c
PRG_OBJ = build/main.o build/ispis.o
PRG_SHARED = bin/run
PRG_STATIC = bin/run_static

LIB_SRC = lib/src/zbir.c
LIB_OBJ = build/zbir.o
STATIC_LIB = lib/bin/libzbir.a
SHARED_LIB = lib/bin/libzbir.so
#----------------------------------------------------
# Podesavanje kompajlera
#
CC = gcc
CFLAGS = -Wall -Wextra -O2 -I./include -I./lib/include
PICFLAGS = -fPIC	
LDFLAGS = -L./lib/bin 

# Ovde navedi i druge biblioteke koje koristis, npr: -lm ... 
LDLIBS = -lzbir
#-----------------------------------------------------
all: libs $(PRG_STATIC) $(PRG_SHARED)

libs: $(STATIC_LIB) $(SHARED_LIB) 

build/%.o: src/%.c
	@mkdir -p build
	$(CC) $(CFLAGS) -c $< -o $@

build/%.o: lib/src/%.c
	@mkdir -p build
	$(CC) $(CFLAGS) $(PICFLAGS) -c $< -o $@

$(STATIC_LIB): $(LIB_OBJ)
	@mkdir -p lib/bin
	ar rcs $@ $^
	
$(SHARED_LIB): $(LIB_OBJ)
	@mkdir -p lib/bin
	$(CC) -shared -o $@ $^

# Linkovanje finalnog programa staticki 
$(PRG_STATIC): $(PRG_OBJ) $(STATIC_LIB) 
	@mkdir -p bin
	$(CC) $(PRG_OBJ) -o $@ $(LDFLAGS) $(LDLIBS) -static

# Linkovanje finalnog programa dinamicki 
$(PRG_SHARED): $(PRG_OBJ) $(SHARED_LIB) 
	@mkdir -p bin
	$(CC) $(PRG_OBJ) -o $@ $(LDFLAGS) $(LDLIBS)

clean:
	@echo "Brisanje binarih fajlova..."
	rm -rf build bin lib/bin

# Mali help
help:
	@echo "Dostupne komande:"
	@echo "  make all       - Napravi oba programa"
	@echo "  make libs      - Napravi samo biblioteke"
	@echo "  make clean     - Očisti sve generisane fajlove"
	@echo ""
	@echo "Ciljevi:"
	@echo "  $(PRG_STATIC)  - Statički linkovan program"
	@echo "  $(PRG_SHARED)  - Dinamički linkovan program"
	@echo "  $(STATIC_LIB)  - Statička biblioteka"
	@echo "  $(SHARED_LIB)  - Dinamička biblioteka"

.PHONY: all libs clean help
	
