var mpq = [];
mpq.push(["init", request.mixpanel_account]);
(function() {
 var mp = document.createElement("script"); mp.type = "text/javascript"; mp.async = true;
 mp.src = (document.location.protocol == 'https:' ? 'https:' : 'http:') + "//api.mixpanel.com/site_media/js/api/mixpanel.js";
 var s = document.getElementsByTagName("script")[0]; s.parentNode.insertBefore(mp, s);
})();