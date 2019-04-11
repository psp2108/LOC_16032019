# import random as r

# l = []

# for i in range(10):
#     z = r.randint(0,10)
#     while z in l:
#         z = r.randint(0,10)
#         print("**")
#     l.append(z)
#     print(z, l)

a = "SDFsdf sdfsee eSEf sdSDFe EFfs'a"
b = a.lower()
b = b.replace(" ", "")
b = b.replace("'", "")
print(b)