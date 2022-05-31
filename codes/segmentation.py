from image_slicer import slice
import os

file_name=input("Enter file name (with path) = ")
size=int(input("enter number pieces wyou want = "))
slice(file_name,size)