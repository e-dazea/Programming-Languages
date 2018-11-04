(* Disclaimer: Parse from: http://stackoverflow.com/questions/37015891/read-file-character-by-character-in-smlnj *)
(* Function that reads the entire file and saves it in a list *)
fun parse file =
let
   	fun next_String input = (TextIO.inputAll input) 
   	val stream = TextIO.openIn file
    	val a = next_String stream
	val b = explode(a)
	
in
    	b
end

(*function that devides string in lines of array *)
fun amazing xartis [] i j w z = (xartis,[], i, j, w, z)
|amazing xartis (x :: []) i j w z = amazing xartis [] i j w z
|amazing xartis (#"S" :: xs) i j w z =
	let 
		val k = i
		val l = j
	in
		Array2.update (xartis, i, j, #"S");
		amazing xartis xs i (j+1) k l
	end
|amazing xartis (#"\n" :: xs) i j w z = amazing xartis xs (i+1) 0 w z
|amazing xartis (x :: xs) i j w z = 
let 
in
	Array2.update (xartis, i, j, x);
	amazing xartis xs i (j+1) w z
end

(* updates prev & "pushes node to queue" (queue here is a list plottwist) *) 
fun queue_lol i_progonou j_progonou kinisi prev i j q p a3 cost costos1=
let
in
	if ((costos1 = ~1 orelse costos1 > cost) andalso kinisi = #"U") then
		let
			val a3 = a3@[(i, j, cost)]
			val k = Array2.update (prev, i, j, (kinisi, i_progonou, j_progonou, cost) )
		in
			(q,p, a3, prev)
		end
	else if ((costos1 = ~1 orelse costos1 > cost) andalso kinisi = #"L") then
		let
			val p = p@[(i, j, cost)]
			val k = Array2.update (prev, i, j, (kinisi, i_progonou, j_progonou, cost) )
		in
			(q,p, a3, prev)
		end
	else if (costos1 = ~1 orelse costos1 > cost) then
		let
			val q = q@[(i, j, cost)]
			val k = Array2.update (prev, i, j, (kinisi, i_progonou, j_progonou, cost) )
		in
			(q,p, a3, prev)
		end
	else (q, p, a3, prev)
end




fun neighbors movement cost = 
let 
in
	if movement = #"U" then (
		let 
			val cost = cost + 3
		in 
			cost
		end
	)
	else if movement = #"L" then (
		let 
			val cost = cost + 2
		in
			cost
		end
	)	
	else (
		let
			val cost = cost + 1
		in
			cost
		end
	)
end

		

fun delete [] = []
|delete [x] = []
|delete (x :: xs) = xs



fun astanapane xartis maria #"L" mikos platos q p a3 cost i j = (* i j ppu vghkan apo ourA *)
let 
in
	if j <> 0 then 
		let  
			val mapp = Array2.sub (xartis, i, (j - 1))
		in
			if mapp = #"X" then (q, p, a3, maria)
			else
				let
					val (mov1, i1, j1, costos1) = Array2.sub (maria, i, (j - 1) )
					val cost = neighbors #"L" cost
					val (q, p, a3, prev) = queue_lol i j #"L" maria i (j - 1) q p a3 cost costos1
				in 
					(q, p, a3, prev)
				end
		end
	else (q, p, a3, maria)
end
| astanapane xartis maria #"R" mikos platos q p a3 cost i j =
let 
in
	if j <> platos then 
		let  
			val mapp = Array2.sub (xartis, i, (j + 1))
		in
			if mapp = #"X" then (q, p, a3, maria)
			else
				let
					val (mov1, i1, j1, costos1) = Array2.sub (maria, i, (j + 1) )
					val cost = neighbors #"R" cost
					val (q, p, a3, prev) = queue_lol i j #"R" maria i (j + 1) q p a3 cost costos1
				in 
					(q, p, a3, prev)
				end
		end
	else (q, p, a3, maria)
end
| astanapane xartis maria #"U" mikos platos q p a3 cost i j =
let 
in
	if i <> 0 then 
		let  
			val mapp = Array2.sub (xartis, (i - 1), j)
		in
			if mapp = #"X" then (q, p, a3, maria)
			else
				let
					val (mov1, i1, j1, costos1) = Array2.sub (maria, (i - 1), j)
					val cost = neighbors #"U" cost
					val (q, p, a3, prev) = queue_lol i j #"U" maria (i - 1) j q p a3 cost costos1
				in 
					(q, p, a3, prev)
				end
		end
	else (q, p, a3, maria)
end
|astanapane xartis maria #"D" mikos platos q p a3 cost i j =
let 
in
	if i <> mikos then 
		let  
			val mapp = Array2.sub (xartis, (i + 1), j)
		in
			if mapp = #"X" then (q, p, a3, maria)
			else
				let
					val (mov1, i1, j1, costos1) = Array2.sub (maria, (i + 1), j)
					val cost = neighbors #"D" cost
					val (q, p, a3, prev) = queue_lol i j #"D" maria (i + 1) j q p a3 cost costos1 
				in 
					(q, p, a3, prev)
				end
		end
	else (q, p, a3, maria)
end
|astanapane xartis maria MOVEMENT mikos platos q p a3 cost i j = (q, p, a3, maria)

fun change [] [] [] a2 xartis =
		let
			val (i, j, cost) = hd a2
			val position = Array2.sub (xartis, i,j) 
			val q = a2
			val a2 = []
		in
			((i, j, cost), position, q, [], [], [])		
		end
	|change [] [] a1 a2 xartis = 
		let
			val (i, j, cost) = hd a1
			val position = Array2.sub (xartis, i,j)
			val q = a1
			val a1 = []
		in
			((i, j, cost), position, q, [], a1, a2)
		end
	|change [] k a1 a2 xartis = 
		let
			val (i, j, cost) = hd k
			val position = Array2.sub (xartis, i,j)
			val q = k
			val k = []
		in
			((i, j, cost), position, q, k, a1, a2)
		end
	|change q k a1 a2 xartis = 
		let
			val (i, j, cost) = hd q
			val position = Array2.sub (xartis, i,j)
		in
			((i, j, cost), position, q, k, a1, a2)
		end


(* checks if queue.top is "E" -> gives result, else makes prev and queue *)
fun check xartis prev mikos platos p a3 ((i, j, cost), #"E", q, k, a1, a2) = 
let
	fun ending prev [] (mov1, i1, j1, costos1) =
		let 	
		in
				let
					val exodus = [mov1]
				in
					ending prev exodus (Array2.sub (prev, i1, j1))
				end
		end
	|ending prev exodus (#"S", i1, j1, costos1) = exodus (* create the path Lakis will use *)
	|ending prev exodus (mov1, i1, j1, costos1) = ending prev ([mov1]@exodus) (Array2.sub (prev, i1, j1))
		
in
	(cost, ending prev [] (Array2.sub (prev, i, j) ) ) 
end 	
| check xartis prev mikos platos p a3 ((i, j, cost), position, q, k, a1, a2) =
let
	val p = []
	val a3 = []
	val (q, p, a3, prev) = astanapane xartis prev #"R" mikos platos q p a3 cost i j
	val (q, p, a3, prev) = astanapane xartis prev #"L" mikos platos q p a3 cost i j
	val (q, p, a3, prev) = astanapane xartis prev #"U" mikos platos q p a3 cost i j
	val (q, p, a3, prev) = astanapane xartis prev #"D" mikos platos q p a3 cost i j
	val q = delete q
	val q = q@k
	val q = q@a1
	val k = p
	val a1 = a2
	val a2 = a3
in
	check xartis prev mikos platos p a3 (change q k a1 a2 xartis)
end

fun xarakaielena [] = (0, "O")
|xarakaielena lista = 
let 
	val xartis = Array2.array (1000, 1000, #".")
	val prev = Array2.array (1000, 1000, (#".", ~1, ~1, ~1) ) 
	val (xartis, _,i, j, w, z) = amazing xartis lista 0 0 0 0 
	val k = Array2.update (prev, w, z, (#"S", 0, 0, 0) )
	val j = j - 1 
	val q = (w, z, 0) :: []
	val p = []
	val k = []
	val a1 = []
	val a2 = []
	val a3 = []
	val position = #"S"
	val (cost, path) = check xartis prev i j p a3 ((w, z, 0), position, q, k, a1, a2)
in
	(cost, implode(path) )
end


fun moredeli fileName = xarakaielena (parse fileName)
(* val prev = Array2.array (2, 2, (#".", ~1, ~1, ~1) ) 
Array2.update (xartis, 0,0,#"S")
Array2.update (xartis, 1,1,#"E")
xarakaielena [#".", #".", #".", #".", #"\n", #"S", #"X", #".", #".", #"\n", #"X", #"E", #"X", #".", #"\n", #".", #".", #".", #".", #"\n"] *)
