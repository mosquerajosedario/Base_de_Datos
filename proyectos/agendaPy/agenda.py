#!/usr/bin/env python3

import tkinter as tk
from tkinter import ttk
from guiCreationModule import *
from helpers import *

def updateDataGrid(dataGrid, contacts):
	dataGrid.delete(*dataGrid.get_children())
	for row in contacts:
		dataGrid.insert('', 'end', text=row["surname"], \
		  values=(row["name"], row["dni"], row["age"], row["address"], row["phone"], row["mail"]))
		
def exitApp(contacts):
	saveData(contacts)
	quit()

contacts = loadData()

mainForm = tk.Tk()
mainForm.geometry("813x500")
mainForm.title("Agenda Python")
centerForm(mainForm)

# Menu
mainMenu = tk.Menu(mainForm)

fileMenu = tk.Menu(mainMenu, tearoff = 0)
fileMenu.add_command(label = "Salir", command = lambda: exitApp(contacts))
mainMenu.add_cascade(label="Archivo", menu = fileMenu)

personMenu = tk.Menu(mainMenu, tearoff = 0)
personMenu.add_command(label = "Alta de persona", command = lambda: createPerson(mainForm, contacts))
personMenu.add_command(label = "Baja de persona")
personMenu.add_command(label = "Modificación de persona")
personMenu.add_separator()
personMenu.add_command(label = "Búsqueda de persona")
personMenu.add_separator()
personMenu.add_command(label = "Actualizar datos...", command = lambda: updateDataGrid(dataGrid, contacts))
mainMenu.add_cascade(label = "Personas", menu = personMenu)

mainForm.config(menu = mainMenu)

dataGrid = ttk.Treeview(mainForm)

dataGrid["columns"]=("name", "dni", "age", "address", "phone", "mail")
dataGrid.heading("#0", text='Apellido')
dataGrid.column("#0", width=100)
dataGrid.column("name", width=100)
dataGrid.column("dni", width=100)
dataGrid.column("age", width=50)
dataGrid.column("address", width=100)
dataGrid.column("phone", width=100)
dataGrid.column("mail", width=250)
dataGrid.heading("name", text="Nombre")
dataGrid.heading("dni", text="DNI")
dataGrid.heading("age", text="Edad")
dataGrid.heading("address", text="Dirección")
dataGrid.heading("phone", text="Teléfono")
dataGrid.heading("mail", text="Correo Electrónico")
dataGrid.place(x = 5, y = 5)

updateDataGrid(dataGrid, contacts)

mainForm.mainloop()

saveData(contacts)
