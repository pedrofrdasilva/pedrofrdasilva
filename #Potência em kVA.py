#Potência em kVA
print('Para a potência em kVA no vão, preencha:')
a=float(input('Corrente da Fase A = '))
b=float(input('Corrente da Fase B = '))
c=float(input('Corrente da Fase C = '))
x=(a+b+c)/3
pot=(x*380)*1.73
kVA=pot/1000
print(f'A potência é de {kVA:.2f}kVA neste vão.')