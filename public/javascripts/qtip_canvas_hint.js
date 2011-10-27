$(".settings").qtip({
  content: $("#canvas-settings-hint").html(),
  show: 'mouseover',
  hide: 'mouseout',
  position: {
    corner: { 
      target: 'bottomLeft', 
      tooltip: 'topRight'
    },
    adjust: { screen: true }
  },
  style: {
    name: 'toolTips',
    tip: {
      corner: 'topLeft'
    }
  }
});