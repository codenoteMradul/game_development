$(document).ready(function(){
  $("#button").click(function(){
    var random = $(".random_number").val();
    var value = $("#game").val();
    var sum = value.split('').reduce(function(total, digit) { return total + parseInt(digit); }, 0);
    debugger
        if(sum == random){
          alert("correct answer")
        }
        else{
          alert("wrong answer")
        }    
  })
})
