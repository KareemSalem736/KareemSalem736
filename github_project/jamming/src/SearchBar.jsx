import { useState } from "react";

export default function SearchBar() {
    const [search, setSearch] = useState('Enter a song');
    const handleChange = (event) => {
            setSearch(event.target.value);
    }

    const handleClick = () => {
        if (search.trim() === '' || search === 'Enter a song') {
            return alert('Please enter a song');
        };
        console.log('Search button clicked');
    }
    return (
        <div>
            <input 
            id='search' 
            type='text' 
            value={search} 
            onChange={handleChange} 
            onClick={() => {
                if (search === 'Enter a song') setSearch('');
                }} />
            <label htmlFor='search'></label>
            <button className='search' onClick={handleClick}>Search</button>
        </div>
    )
}
