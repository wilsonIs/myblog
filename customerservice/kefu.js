var demo = angular.module("demo", ["RongWebIMWidget"]);

demo.controller("main", ["$scope","$http","WebIMWidget", function($scope,$http,WebIMWidget) {
  $scope.title="asdf";
  WebIMWidget.init({
        appkey:"e0x9wycfedavq",//selfe
        token:"sAyqKrXZWVFrwdlV1eYr2zq4Z6Kfbg937f6uviBR0qaND79pgBVEJ/6N0YmxqowTMkyC+8JeJXjjACtmO0fHg6zIf0YwGIij",//selfe kefu
        kefuId:"KEFU147884718554428",//selfe
        reminder:"博主wilsonIs",
        __isKefu:true,
        style:{
          height:500,
          width:500,
          right:10
        },
        onSuccess:function(e){
          console.log(e);
        }
  })
  WebIMWidget.onShow=function(){
    WebIMWidget.setConversation(WebIMWidget.EnumConversationType.CUSTOMER_SERVICE, "KEFU145914839332836","客服")
  }

    $scope.show = function() {
      WebIMWidget.show();
    }

    $scope.hidden = function() {
      WebIMWidget.hidden();
    }
}]);
