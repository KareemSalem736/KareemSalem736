/*
Kareem Salem    
Git, Github, and Node test
*/

/*
This program generates a random sentence with three different random words from three different arrays.
*/

const arr1 = ['Giraffe', 'Elephant', 'Lion', 'Tiger', 'Zebra'];
const arr2 = ['house', 'car', 'bike', 'plane', 'boat'];
const arr3 = ['happy', 'sad', 'angry', 'excited', 'bored'];

const randomWord1 = arr1[Math.floor(Math.random() * arr1.length)];
const randomWord2 = arr2[Math.floor(Math.random() * arr2.length)];
const randomWord3 = arr3[Math.floor(Math.random() * arr3.length)];

console.log(`The ${randomWord3} ${randomWord1} went to the ${randomWord2}.`);

//react statehook
import React, {useState, useEffect} from 'react';

const lightSwitch = () => {
    const [light, setLight] = useState('Off');

    const toggleLight = () => {
        setLight(prev => prev === 'Off' ? 'On' : 'Off');
    }

    useEffect (() => {
        console.log(`Light is now ${light}`);
    }, [light]);

    return (
        <div>
            <p>Light is {light}</p>
            <button onClick={toggleLight}>Toggle Light</button>
        </div>
    );
};

export default lightSwitch;