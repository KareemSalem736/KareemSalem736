"use strict"

const obj = {
    val: 10,
    getVal() {
      return this.val;
    }
  };
  
  const f = obj.getVal;
  console.log(f()); // undefined
  