#Box stack
#pseudocode - non DP 
#Problem: 
#   The problem involves stacking a set of boxes to achieve the maximum possible height. 
#   Each box has dimensions (length, width, and height), and you can not rotate the boxes.
#   The challenge is to stack the boxes such that no box rests on a smaller box in both length and width.

def get_max_height(boxes, bottom_box):
    max_height = 0
    for top_box in boxes:
        if top_box[0] < bottom_box[0]  and top_box[1] < bottom_box[1]:
            height = get_max_height(boxes, top_box)
            max_height = max(max_height, height)
    return max_height + bottom_box[2]

def BoxStack(boxes):
    max_height = 0
    for box in boxes:
        height = get_max_height(boxes, box)
        max_height = max(max_height, height)
    return max_height

def main():
    boxes = [
        [1, 2, 3], 
        [2, 4, 7], 
        [7, 1, 9], 
        [3, 8, 5], 
        [1, 2, 9]]
    print(BoxStack(boxes))

if __name__ =='__main__':
    main()