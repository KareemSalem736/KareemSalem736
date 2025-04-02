const buttons = document.querySelectorAll("button[id^='open-popup']");
const popups = document.querySelectorAll(".popup");
const closes = document.querySelectorAll(".close");

buttons.forEach((btn) => {
    btn.onclick = () => {
        const id = btn.id.replace("open-", "");
        document.getElementById(id).style.display = "flex";  
    };
});

closes.forEach((span) => {
    span.onclick = () => {
        span.closest(".popup").style.display = "none";
    };
});

window.onclick = (event) => {
    popups.forEach((popup) => {
        if (event.target === popup) {
            popup.style.display = "none";
        }
    });
};