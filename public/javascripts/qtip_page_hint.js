$(".add_page").qtip({
  content: $("#new-page-hint").html(),
  show: 'mouseover',
  hide: 'mouseout',
  position: {
    corner: { 
      target: 'bottomLeft', 
      tooltip: 'topRight'
    },
    adjust: { screen: true }
  },
  style: 'toolTips'
});