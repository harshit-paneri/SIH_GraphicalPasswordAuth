import os
from image_slicer import slice , save_tiles as st
dataset=r"D:\SIH2022\GPA\GraphicalPasswordAuth\GraphicalPasswordAuth\static\dataset"
segments=r"D:\SIH2022\GPA\GraphicalPasswordAuth\GraphicalPasswordAuth\static\segments"
j=1
for i in os.listdir(dataset):
    new_path=segments+"\\"+i[-4:]+"_"+str(j)+'.jpg'
    tiles=slice(dataset+"\\"+i,9,save=False)
    x=i[:-4]
    os.mkdir(segments+"\\"+x)
    st(tiles,directory=segments+"\\"+x,prefix=x,format="png")
    files = os.listdir(segments+"\\"+x)
    for f in files:
        # print(f)
        os.rename(segments+"\\"+x+"\\"+f,segments+"\\"+x+"\\"+x+"_"+str(files.index(f)+1)+".png")