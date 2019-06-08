class ChessPiece(object):

	"""
	Chess pieces are what we will add to the squares on the board
	Chess pieces can either moves straight, diagonally, or in an l-shape
	Chess pieces have a name, a color, and the number of squares it traverses per move
	"""

	Color = None
	Type = None

	ListofPieces = [ "Rook", "Knight", "Pawn", "King", "Queen", "Bishop" , "Random"]

	def __init__(self, dict_args):
		""" Constructor for a new chess piece """

		self.Type = dict_args["Type"]

		self.Color = dict_args["Color"]
		

	def __str__(self):
		""" Returns the piece's string representation as the first letter in each word
			example: bN - black knight,  wR - white rook"""
		if self.Type in ["Rook", "Knight", "Pawn", "King", "Queen", "Bishop"]:
			color = self.Color[0]
			if(self.Type != "Knight"):
				pieceType = self.Type[0]
			else:
				pieceType = "N"	
			return color.lower() + pieceType.upper()
		else: 
			return "  "

