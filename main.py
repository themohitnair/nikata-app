import flet as ft

title = 'Nikata'

class Home(ft.UserControl):
    def build(self):
        self.name = ft.TextField(hint_text='Enter your name')

class CID(ft.UserControl):
    def __init__(self, CID, delete_CID):
        super().__init__()
        self.CID = CID
        self.delete_CID = delete_CID

def main(page: ft.Page):
    page.theme_mode = 'dark'
    page.title = title

    context_bar = ft.AppBar(
        adaptive=True,
        title=ft.Text(value='Home', color=ft.colors.WHITE),
        center_title=True,
        bgcolor=ft.colors.INDIGO
    )

    nav_bar = ft.NavigationBar(
        height=100,
        adaptive=True,
        destinations=[
            ft.NavigationDestination(
                icon=ft.icons.EXPLORE_OUTLINED, 
                label='Geofences',
                selected_icon=ft.icons.EXPLORE
            ), 
            ft.NavigationDestination(
                icon=ft.icons.PERSON_PIN_CIRCLE_OUTLINED,
                label='Credentials',
                selected_icon=ft.icons.PERSON_PIN_CIRCLE
            ),
            ft.NavigationDestination(
                icon=ft.icons.MESSAGE_OUTLINED,
                label='Informed',
                selected_icon=ft.icons.MESSAGE_ROUNDED
            )
        ],
        bgcolor=ft.colors.GREY_900
    )

    page.add(context_bar)
    page.add(nav_bar)


ft.app(target=main)