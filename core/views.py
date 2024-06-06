from string import ascii_lowercase, ascii_uppercase, digits
import random

from django.shortcuts import render

# Create your views here.


def home(request):
    if request.method == "POST":
        form = request.POST
        if not any(
            key in form
            for key in [
                "numbersChecked",
                "lowerChecked",
                "upperChecked",
                "specialChecked",
            ]
        ):
            return render(
                request,
                "core/index.html",
                {
                    "message": "Cochez au moins une option pour générer un mot de passe.",
                    "form": form,
                },
            )

        length = int(form["length"])

        allowedChars = ""
        if "numbersChecked" in form:
            allowedChars += digits
        if "lowerChecked" in form:
            allowedChars += ascii_lowercase
        if "upperChecked" in form:
            allowedChars += ascii_uppercase
        if "specialChecked" in form:
            allowedChars += "!@#$%^&*()_+{}|:<>?"

        res = {
            f"pass_{i}": "".join(random.choice(allowedChars) for _ in range(length))
            for i in range(21)
        }
        return render(request, "core/index.html", {"password": res, "form": form})
    else:

        return render(
            request,
            "core/index.html",
            {
                "form": {
                    "length": 12,
                    "numbersChecked": "on",
                    "lowerChecked": "on",
                    "upperChecked": "on",
                }
            },
        )
