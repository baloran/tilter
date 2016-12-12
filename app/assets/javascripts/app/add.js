var Add = function() {

	'use strict';
	
	var $addToggler = $('.add');
	var MAX_CHARACTERS = 139;

	var init = function() {

		$addToggler.on('click', function(e) {_bindClick($(this));});
		$addToggler.each(function() {
			var $add = $(this);
			var $close = $(this).find('.add__remove');
			$close.on('click',function() {
				console.log('hey');
				$add.parent().hide();
				$add.parent().prev().removeClass('feed__row--with-add');
			});
		})
	};

	var _bindClick = function($elem) {
		if (!$elem.hasClass('add-active')) {
			$elem.addClass('add--active');
			var $input = $elem.find('.add__text');
			var $charactersCount = $elem.find('.add__character-count');
			$input.focus();
			$input.on('keydown, keyup', function() {_bindKeydown($input,$charactersCount);});
		}
	};

	var _bindKeydown = function($input,$charactersCount) {
		var charactersLeft = MAX_CHARACTERS - $input.val().length;
		$charactersCount.text(charactersLeft);
		if (charactersLeft < 0) {
			$charactersCount.addClass('add__character-count--error');
		} else {
			$charactersCount.removeClass('add__character-count--error');
		}
	};

	init();

	return {
		init: init,
	};

};