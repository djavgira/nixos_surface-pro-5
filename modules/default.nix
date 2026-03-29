{ pkg , lib , options , config , ...}:
{
	imports = 
	[
	./core/default.nix
	./desktop/default.nix
	./extra/default.nix
	./hardware/default.nix
	./program/default.nix
	./fcitx5/default.nix
	];

		
}

