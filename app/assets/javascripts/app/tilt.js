var Tilt = function() {

	'use strict';
	
	var $tilt = $('.tilt');

	var init = function() {

		$tilt.each(function() {

			var $this = $(this);
			
			var replyToggler = $this.find('.tilt__action--reply');

			replyToggler.on('click', function() {
				_toggleReply($this);
			});

		});

	};

	var _toggleReply = function($this) {
		
		var $row = $this.parent();
		var $nextRow = $row.next();
		console.log($row, $nextRow);

		$row.addClass('feed__row--with-add');
		$nextRow.removeClass('feed__row--hidden');

	};

	init();

	return {
		init: init,
	};

};