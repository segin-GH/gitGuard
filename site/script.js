const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

document.addEventListener("DOMContentLoaded", () => textEffect(document.querySelector("h1")));


function textEffect(element) {
    let iterations = 0;
    const originalText = element.dataset.value || element.innerText;
    element.dataset.value = originalText;

    const interval = setInterval(() => {
        element.innerText = originalText.split("").map((letter, index) => {
            if (index < iterations) {
                return originalText[index];
            } else {
                return letters[Math.floor(Math.random() * 26)];
            }
        }).join("");

        if (iterations >= originalText.length) {
            clearInterval(interval);
        }
        iterations += 1 / 3;
    }, 40);
}
