var Submenu = function() {

	'use strict';
	
	var $submenuToggler = $('.tilt__action--more');

	var init = function() {

		$submenuToggler.on('click', function(e) {_bindClick($(this));});

	};

	var _bindClick = function(elem) {

		var $submenu = elem.find('.submenu');
		
		$submenu.addClass('submenu--active');

		setTimeout(function(){
			$(window).on('click', function(e) {
				if (!$submenu.is(e.target) && $submenu.has(e.target).length === 0) {
					$submenu.removeClass('submenu--active');
					$(window).off('click');
				}
			});
		}, 10);

	};

	init();

	return {
		init: init,
	};

};