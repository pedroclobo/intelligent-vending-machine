import string
alphabet = dict.fromkeys(string.ascii_uppercase, 0)
product = ["Cat_Hands","Cat_Shoe","Cone_Shelf","Post_office_Video_games","YouTube_Laptop","System_Monster","Drugs_Boat","Crab_Whale","Shower_Body","Shoe_Toolbox", "Water","Solar","Body","Soap","Breakfast","Poop","Ice_cream","Male","Solar","Book", "Cone","Kitty","Running","Kitty", "Plants", "Cat","Dislike","Dog","Floppy_Disk","BBQ"]
category = ["Fantasy","Fiction", "Animals", "Condiments", "Arms", "Countries", "Roads"]

maker = ["Andrade - Lima", "Fernandes, Morais and Raposo", "Amaral, Gomes and Oliveira", 
"Coelho Comercio", "Moreira S.A.", "Pinheiro S.A.", "Moura, Pinheiro and Marques",
"Mota, Melo and Paiva", "Vaz e Associados", "Gomes e Associados", "Moreira - Faria",
"Jesus - Ferreira", "Castro, Morais and Paiva", "Antunes - Mota", "Brito - Henriques", 
"Cardoso - Machado", "Marques LTDA", "Loureiro - Esteves", "Carneiro S.A",
"Saraiva - Ribeiro"]

simple_cat = []
super_cat = []
has_others = []
has_otherc = []
file_object = open('populateWithoutDB.sql', 'a')

def create_product():
    i = 0
    for p in product:
        ins = 'INSERT INTO produto VALUES (' + str(i) + ', "'+ p +'")\n'
        file_object.write(ins)
        i+=1
    file_object.write('\n')

def create_simple_category():
    for c in simple_cat:
        ins = 'INSERT INTO categoria_simples VALUES ("'+ c +'")\n'
        file_object.write(ins)
    file_object.write('\n')

def create_super_category():
    for s in super_cat:
        ins = 'INSERT INTO super_categoria VALUES ("'+ s +'")\n'
        file_object.write(ins)
    file_object.write('\n')

def create_has_other():
    i = 0
    size = len(has_otherc)
    while(i < size):
        ins = 'INSERT INTO tem_outra VALUES ("' + has_others[i] + '", "'+ has_otherc[i] +'")\n'
        file_object.write(ins)
        i+=1
    file_object.write('\n')

def create_has_cat():
    i = 0
    size = len(category)
    while(i < size):
        ins = 'INSERT INTO tem_categoria VALUES (' + i + ', "'+ category[i] +'")\n'
        file_object.write(ins)
        i+=1
    file_object.write('\n')

def create_category():
    super = dict.fromkeys(string.ascii_uppercase, "")
    for p in category:
        ins = 'INSERT INTO categoria VALUES ("'+ p +'")\n'
        file_object.write(ins)
        if alphabet[p[0]] == 0:
            alphabet[p[0]] += 1
            super[p[0]] = p
            simple_cat.append(p) 
        else:
            simple_cat.remove(super[p[0]]) 
            super_cat.append(super[p[0]]) 
            simple_cat.append(p) 
            has_others.append(super[p[0]]) 
            has_otherc.append(p) 
    file_object.write('\n')

def create_ivm():
    i = 0
    for m in maker:
        ins = 'INSERT INTO ivm VALUES (' + str(i) + ', "'+ m +'")\n'
        file_object.write(ins)
        i+=1
    file_object.write('\n')

create_product()
create_category()
create_super_category()
create_simple_category()
create_has_other()
create_has_cat()
create_ivm()
file_object.close()