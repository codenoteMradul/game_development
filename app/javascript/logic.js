$(document).ready(function(){  
  $("#button").click(function(){ 
    var point = 0
    var random = $("#number")[0].value;
    var value = $("#game").val();  
    var sum = value.split('').reduce(function(total, digit) { return total + parseInt(digit); }, 0);
    debugger
    if(sum == random){
      point += 50  
      var up_point = $(".points")[0].innerHTML = point
    }
    else{ 
      point -= 100
      var down_point = $(".points")[0].innerHTML = point
      alert("Game Over")       
      // window.location.href = '/game_over';
    }    

    $.ajax({
      url: '/final_point',
      type: 'GET',
      dataType: 'script',
      data: {point: $(".points")[0].innerHTML},
      success: function(){
        $(window).scrollTop();
      }
    });    
  }); 
});
  