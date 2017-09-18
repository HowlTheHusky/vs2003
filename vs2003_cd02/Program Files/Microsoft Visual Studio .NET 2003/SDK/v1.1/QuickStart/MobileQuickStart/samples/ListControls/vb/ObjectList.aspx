<%@ Page Inherits="System.Web.UI.MobileControls.MobilePage" Language="VB" %>

<script runat="server" language="VB">

Public Class WeatherCity

    Dim _cityName, _condition, _high, _low, _forecast As String

    Public Sub New(cityName As String, condition As String, high As String, low As String, forecast As String)

        _cityName = cityName
        _condition = condition
        _high = high
        _low = low
        _forecast = forecast

    End Sub

    Public ReadOnly Property CityName As String
        Get
            Return _cityName
        End Get
    End Property

    Public ReadOnly Property Condition As String
        Get
            Return _condition
        End Get
    End Property

    Public ReadOnly Property High As String
        Get
            Return _high
        End Get
    End Property

    Public ReadOnly Property Low As String
        Get
            Return _low
        End Get
    End Property

    Public ReadOnly Property Forecast As String
        Get
            Return _forecast
        End Get
    End Property

End Class

Protected Sub Page_Load(sender As Object, e As EventArgs)

    If (Not IsPostBack)

        Dim array As New ArrayList()
        array.Add(New WeatherCity("Sydney", "Windy", "52F", "40F", "Sunny through weekend, with occasional cloudy periods"))
        array.Add(New WeatherCity("Tel Aviv", "Sunny", "75F", "52F", "Sunny all weekend"))
        array.Add(New WeatherCity("New York", "Rainy", "58F", "38F", "Cold and cloudy with periods of rain"))
        array.Add(New WeatherCity("Madrid", "Cloudy", "70F", "48F", "Cloudy with a chance of rain on Sunday"))
        array.Add(New WeatherCity("Tokyo", "Cloudy", "65F", "42F", "Cloudy skies through weekend, clearing Sunday"))

        CitiesList.DataSource = array
        CitiesList.DataBind()

    End If

End Sub

Protected Sub Cities_OnItemCommand(sender As Object, e As ObjectListCommandEventArgs)

    CityLabel.Text = e.ListItem("CityName")
    WeatherLabel.Text = e.ListItem("Forecast")
    ActiveForm = SecondForm

End Sub

</script>

<mobile:Form runat="server">
    <mobile:Label runat="server" StyleReference="title">Local Weather</mobile:Label>
    <mobile:ObjectList runat="server" id="CitiesList" AutoGenerateFields="false"
            OnItemCommand="Cities_OnItemCommand" LabelField="CityName">
        <Field DataField="CityName" Title="City" />
        <Field DataField="Condition" Title="Condition" />
        <Field DataField="High" Title="High" />
        <Field DataField="Low" Title="Low" />
        <Field DataField="Forecast" Visible="False" />
        <Command Name="Forecast" Text="Long Range Forecast" />
    </mobile:ObjectList>
</mobile:Form>

<mobile:Form id="SecondForm" runat="server">
    <b>Weather for: </b><mobile:Label runat="server" id="CityLabel" />
    <mobile:Label runat="server" id="WeatherLabel" />
</mobile:Form>

