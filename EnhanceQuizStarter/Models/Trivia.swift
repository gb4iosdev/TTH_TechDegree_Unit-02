//
//  Trivia.swift
//  EnhanceQuizStarter
//
//  Created by Gavin Butler on 01-07-2019.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

struct Trivia {
    
    //Acknowledgements: https://www.theguardian.com/tv-and-radio/quiz/2015/apr/11/game-of-thrones-quiz
    
    var questions: [Question] = [
        Question(question: "Who was responsible for the creation of the Night King", answers:
            ["The Lord of Light",
             "The Children of the Forest",
             "The Drowned God",
             "The First Men"
            ], correctAnswer: 1, imageName: "nightKing"),
        Question(question: "What was Hodor called before he got his tragic door-holding nickname?", answers:
            ["Wylis",
             "Horys",
             "Myrys",
             "Gladys"
            ], correctAnswer: 0, imageName: "hodor"),
        Question(question: "Dany’s dragons are (or were) called Drogon, Viserion and ____?", answers:
            ["Dougal",
             "Vhagar",
             "Rhaegal",
             "Balerion"
            ], correctAnswer: 2, imageName: "dragon"),
        Question(question: "Iwan Rheon, who played Ramsay Bolton, was almost cast as which character?", answers:
            ["Jon Snow",
             "Gendry",
             "Podrick Payne",
             "Robb Stark"
            ], correctAnswer: 0, imageName: "ramsay"),
        Question(question: "Who said: 'I don’t plan on knitting by the fire while men fight for me'?", answers:
            ["Lyanna Mormont",
             "Sansa Stark",
             "Ser Brienne of Tarth",
             "Olenna Tyrell"
            ], correctAnswer: 0, imageName: "default"),
        Question(question: "Which of these characters is dead?", answers:
            ["Jaqen H’Gar",
             "Nymeria the direwolf",
             "Hot Pie",
             "Eddison Tollett"
            ], correctAnswer: 3, imageName: "default"),
        Question(question: "What is the name of the giant dragon-slaying crossbow that failed to protect King’s Landing?", answers:
            ["Millipede",
             "Scorpion",
             "Mantis"
            ], correctAnswer: 1, imageName: "crossbow"),
        Question(question: "Where is the House of Black and White, the training temple of the Faceless Men?", answers:
            ["Qarth",
             "Braavos",
             "Meereen",
             "No one knows"
            ], correctAnswer: 1, imageName: "facelessMen"),
        Question(question: "What was the Red Keep’s chief mouser (RIP) called?", answers:
            ["Ser Pounce",
             "Maester Paw",
             "The Bastard"
            ], correctAnswer: 0, imageName: "chiefMouser"),
        Question(question: "Which relative did Euron Greyjoy murder to take the Salt Throne of the Iron Islands?", answers:
            ["His brother",
             "His uncle",
             "His nephew",
             "His cousin"
            ], correctAnswer: 0, imageName: "greyJoy"),
        Question(question: "What is the name of Arya’s sword?", answers:
            ["Ice",
             "Pointy",
             "Fang",
             "Needle"
            ], correctAnswer: 3, imageName: "needle"),
        Question(question: "In which King’s Landing slum did Gendry grow up?", answers:
            ["Flea Bottom",
             "Rat Bottom",
             "Rhaenys’s Hill",
             "Dragonpit"
            ], correctAnswer: 0, imageName: "gendry"),
        Question(question: "Who was Ned Stark’s predecessor as Robert Baratheon’s Hand?", answers:
            ["Jaime Lannister",
             "Jon Arryn",
             "Tywin Lannister",
             "Ser Jorah Mormont"
            ], correctAnswer: 1, imageName: "ned"),
        Question(question: "Whose last words were: 'Give me something for the pain, and let me die'?", answers:
            ["Stannis Baratheon",
             "Hodor",
             "Robert Baratheon",
             "Walder Frey"
            ], correctAnswer: 2, imageName: "default"),
        Question(question: "How many kings and queens of Westeros did Lord Varys serve?", answers:
            ["2",
             "3",
             "4",
             "5"
            ], correctAnswer: 2, imageName: "varys"),
        Question(question: "Who had the honour of killing Petyr Baelish?", answers:
            ["Jon Snow",
             "Sansa Stark",
             "Brienne",
             "Arya Stark"
            ], correctAnswer: 3, imageName: "petyr"),
        Question(question: "In Westerosian currency, the two smaller denominations of the Gold Dragon coin are the copper penny and the ___?", answers:
            ["Silver stallion",
             "Golden goose",
             "Silver stag",
             "Bronze bull"
            ], correctAnswer: 2, imageName: "coin"),
        Question(question: "What is the go-to anaesthetic for maesters across Westeros called?", answers:
            ["Shade of the evening",
             "Sourleaf",
             "Milk of the poppy"
            ], correctAnswer: 2, imageName: "maester")
    ]
}
