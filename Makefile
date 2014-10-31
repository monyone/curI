TARGET = curI
OBJS = curI.o
AA := $(wildcard aa/*.aa)
AA_HEADER = aa.h
DATS := $(addsuffix .dat, $(basename $(AA)))

CC = gcc
CFLAGS = -Wall

.SUFFIXES: .c .o
.SUFFIXES: .aa .dat

.PHONY: all
all: $(TARGET)

.aa.dat: 
	echo "#define" `echo $* | sed "s/aa\///g" | tr "[:lower:]" "[:upper:]"` '(\\' > $@
	cat $< | sed -e 's/^/\"/g' | sed -e 's/$$/\" \"\\n\" \\/g' | cat >> $@
	#echo "" >> $@
	echo "\"\")" >> $@

$(OBJS): $(AA_HEADER)

$(AA_HEADER): $(DATS)
	ls -1 aa | grep .dat  | sed -e 's/^/#include \"aa\//g' | sed -e 's/$$/\"/g' > $(AA_HEADER)	
	echo "" >> $(AA_HEADER)
	echo "#define AA_SIZE `ls -1 aa | grep .dat | wc -l`" >> $(AA_HEADER)
	echo "" >> $(AA_HEADER)
	echo "const char const * aa_array[] = {" >> $(AA_HEADER)
	echo '    '`ls -C aa/*.dat | sed "s/.dat//g" | sed "s/aa\///g" | tr [:lower:] [:upper:] | sed -e "s/[ ][ ]*/, /g"` >> $(AA_HEADER)
	echo "};" >> $(AA_HEADER)
	
	
$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $(TARGET) $^

run:
	./$(TARGET)

clean:
	$(RM) $(OBJS) $(DATS) $(AA_HEADER)

all-clean: clean
	$(RM) $(TARGET)
