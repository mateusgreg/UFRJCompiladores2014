all: trabalho entrada.cc
#	./trabalho < entrada.cc > saida.c
#	../gabarito/trabalho < saida.c
#	g++ -o saida saida.c
#	./saida

	./trabalho < entrada_mdc.cc > saida_mdc.c
	../gabarito/trabalho < saida_mdc.c
	g++ -o saida_mdc saida_mdc.c
	./saida_mdc

#	./trabalho < entrada_matrizes.cc > saida_matrizes.c
#	../gabarito/trabalho < saida_matrizes.c
#	g++ -o saida_matrizes saida_matrizes.c
#	./saida_matrizes

#	./trabalho < entrada_equacao2grau.cc > saida_equacao2grau.c
#	../gabarito/trabalho < saida_equacao2grau.c
#	g++ -o saida_equacao2grau saida_equacao2grau.c
#	./saida_equacao2grau

lex.yy.c: trabalho.lex
	lex trabalho.lex

y.tab.c: trabalho.y
	yacc trabalho.y

trabalho: lex.yy.c y.tab.c
	g++ -o trabalho y.tab.c -lfl
