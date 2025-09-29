pointsLoaded = true
spd += 0.0001

//Animação do score subindo
for(var i = 0; i < array_length(finalScore)-1;i++){
	if finalScoreAnimated[i] < finalScore[i] {
		pointsLoaded = false
		finalScoreAnimated[i] += spd
		}
	}