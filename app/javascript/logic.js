$(document).ready(function(){
  $("#button").click(function(){
    var random = $(".random_number").val();
    var value = $("#game").val();
    var sum = 0;
     for(;value>0;){
      var rem = value%10;
      sum = sum+rem;
        rem = rem/10;
    debugger  
      }
        if(sum == random){
          alert("correct answer")
        }
        else{
          alert("wrong answer")
        }    
  })
})
