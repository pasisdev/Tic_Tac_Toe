unit GameViewplay;

interface

uses Classes,
  CastleVectors, CastleUIControls, CastleControls, CastleKeysMouse;

type

  { TViewplay }

  TPlayer = (pEmpty, pO, pX);

  TViewplay = class(TCastleView)
  published
    { Components designed using CGE editor.
      These fields will be automatically initialized at Start. }
    // ButtonXxx: TCastleButton;
    verticalgroup1: TCastleVerticalGroup;
    horizontalgroup1: TCastleHorizontalGroup;
    horizontalgroup2: TCastleHorizontalGroup;
    horizontalgroup3: TCastleHorizontalGroup;
    button1: TcastleButton;
    button2: TcastleButton;
    button3: TcastleButton;
    button4: TcastleButton;
    button5: TcastleButton;
    button6: TcastleButton;
    button7: TcastleButton;
    button8: TcastleButton;
    button9: TcastleButton;
    Reset: TcastleButton;
    X: TCastleCheckbox;
    O: TCastleCheckbox;
    label1: TCastleLabel;
    Label2: TCastleLabel;
  private
    Button: array [1..9] of TCastleButton;
    gamestate: array[1..9] of Tplayer;
    procedure MakeMove(Sender: TObject);
    procedure playerTurn(Sender: TObject);
    procedure playerTurn2(Sender: TObject);
    procedure checkwinner;
    procedure newgame(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure Start; override;
    procedure Update(const SecondsPassed: single; var HandleInput: boolean); override;
  end;

var
  Viewplay: TViewplay;

implementation

uses
  SysUtils;

var
  i: integer;

procedure TViewplay.MakeMove(Sender: TObject);
var
  btn: TCastleButton;
  d: integer;
begin
  btn := Sender as TCastleButton;
  d := btn.Tag;
  if gamestate[d] = pEmpty then
  begin
    if O.Checked then
    begin
      gamestate[d] := pO;
      btn.Image.Url := 'castle-data:/O.png';
      O.Checked := False;
      X.Checked := True;
      Label1.Exists := False;
      O.Exists := False;
      X.Exists := False;
      Label2.Exists := True;
      Label2.Caption := 'Game is in Progress';
    end
    else
    begin
      gamestate[d] := pX;
      btn.Image.Url := 'castle-data:/X.png';
      O.Checked := True;
      X.Checked := False;
      Label1.Exists := False;
      O.Exists := False;
      X.Exists := False;
      Label2.Exists := True;
      Label2.Caption := 'Game is in Progress';
    end;
  end;
end;

procedure TViewplay.playerTurn(Sender: TObject);
begin
  if not Label1.Exists then
  else
  begin
    if O.Checked then
    begin
      O.Checked := True;
      X.Checked := False;
    end
    else
    begin
      O.Checked := False;
      X.Checked := True;
    end;
  end;
end;

procedure TViewplay.playerTurn2(Sender: TObject);
begin
  if not Label1.Exists then
  else
  begin
    if X.Checked then
    begin
      X.Checked := True;
      O.Checked := False;
    end
    else
    begin
      X.Checked := False;
      O.Checked := True;
    end;
  end;
end;

procedure TViewplay.checkwinner;
var
  z: integer;
begin
  if ((gamestate[1] = pO) and (gamestate[2] = pO) and (gamestate[3] = pO)) or
    ((gamestate[4] = pO) and (gamestate[5] = pO) and (gamestate[6] = pO)) or
    ((gamestate[7] = pO) and (gamestate[8] = pO) and (gamestate[9] = pO)) or
    ((gamestate[1] = pO) and (gamestate[4] = pO) and (gamestate[7] = pO)) or
    ((gamestate[2] = pO) and (gamestate[5] = pO) and (gamestate[8] = pO)) or
    ((gamestate[3] = pO) and (gamestate[6] = pO) and (gamestate[9] = pO)) or
    ((gamestate[1] = pO) and (gamestate[5] = pO) and (gamestate[9] = pO)) or
    ((gamestate[3] = pO) and (gamestate[5] = pO) and (gamestate[7] = pO)) then
  begin
    label2.Caption := 'Game Over. O Wins';
    for z := 1 to 9 do
    begin
      button[z].Enabled := False;
    end;
  end
  else if ((gamestate[1] = pX) and (gamestate[2] = pX) and (gamestate[3] = pX)) or
    ((gamestate[4] = pX) and (gamestate[5] = pX) and (gamestate[6] = pX)) or
    ((gamestate[7] = pX) and (gamestate[8] = pX) and (gamestate[9] = pX)) or
    ((gamestate[1] = pX) and (gamestate[4] = pX) and (gamestate[7] = pX)) or
    ((gamestate[2] = pX) and (gamestate[5] = pX) and (gamestate[8] = pX)) or
    ((gamestate[3] = pX) and (gamestate[6] = pX) and (gamestate[9] = pX)) or
    ((gamestate[1] = pX) and (gamestate[5] = pX) and (gamestate[9] = pX)) or
    ((gamestate[3] = pX) and (gamestate[5] = pX) and (gamestate[7] = pX)) then
  begin
    label2.Caption := 'Game Over. X Wins';
    for z := 1 to 9 do
    begin
      button[z].Enabled := False;
    end;
  end;
end;

procedure TViewplay.newgame(Sender: TObject);
var
  z: integer;
begin
  X.Checked := True;
  O.Checked := False;
  for i := 1 to 9 do
  begin
    button[i].image.url := 'castle-data:/Blank.png';
  end;
  Label1.Exists := True;
  Label1.Caption := 'Who Moves First?';
  X.Exists := True;
  O.Exists := True;
  Label2.Exists := False;
  for z := 1 to 9 do
  begin
    gamestate[z] := pEmpty;
    button[z].enabled := true;
  end;
end;

constructor TViewplay.Create(AOwner: TComponent);
begin
  inherited;
  DesignUrl := 'castle-data:/gameviewplay.castle-user-interface';
end;

procedure TViewplay.Start;
begin
  inherited;
  { Executed once when view starts. }
  for i := 1 to 9 do   //assign button
  begin
    Button[i] := DesignedComponent('button' + IntToStr(i)) as TCastleButton;
    gamestate[i] := pEmpty;
  end;

  O.OnChange := @playerTurn;//select who goes first
  x.OnChange := @playerTurn2;//select who goes first

  for i := 1 to 9 do  //renders x or o to screen
  begin
    Button[i].Tag := i;
    Button[i].onclick := @MakeMove;
  end;

  reset.onclick := @newgame;
end;

procedure TViewplay.Update(const SecondsPassed: single; var HandleInput: boolean);
begin
  inherited;
  { Executed every frame.}
  checkwinner;
end;

end.
