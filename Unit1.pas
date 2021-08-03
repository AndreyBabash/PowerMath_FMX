unit Unit1;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, System.Rtti,
  FMX.Grid.Style, FMX.Grid, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.StdCtrls, FMX.Edit, FMX.Layouts, FMX.Memo;

  //   ������������ �������
  type TMatrix = Array of Array of Extended;
  type TVector = Array of Extended;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Layout1: TLayout;
    Memo1: TMemo;
    ToolBar1: TToolBar;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StringGridConstructor(var sg:TStringGrid; var rowcol:integer; var Layout:TLayout);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    elementscol:integer;
    stringcolumn:TArray<TStringColumn>;
    MyStringGrid:TStringGrid;
    n1,n, i,j,matrix_size:integer;
    A: TMatrix;
    D, X: TVector;
    public function Gauss(n:integer; A:TMatrix; D:TVector):TVector;
  end;



var
  Form1: TForm1;

implementation

{$R *.fmx}


//-----------�������� ������ ������---------------------------

function TForm1.Gauss(n:integer; A:TMatrix; D:TVector):TVector;
Var
   i,j,k: integer;
   S: extended;
   B: TMatrix;
   C: TMatrix;
   X,Y: TVector;
begin

//   ������������� ������������ ���������
  Setlength(B, n);

  for i:=0 to n-1 do
  begin
    Setlength(B[i], n);
  end;

    Setlength(C,n);

  for i:=0 to n-1 do
  begin
    Setlength(C[i], n);
  end;

  Setlength(X,n);

  Setlength(Y,n);

  // ����� ������

  for i:=0 to n-1 do

  begin
    B[i,i]:=1;
    B[0,i]:=A[0,i]/A[0,0];
    C[i,0]:=A[i,0];
  end;

  Y[0]:=D[0]/A[0,0];

  for i:=1 to n-1 do
  begin
    for k:=i to n-1 do
    begin
      S:= 0;
      for j:=0 to i-1 do
        S:=S+C[k,j]*B[j,i];
      C[k,i]:=A[k,i]-S;
    end;

    for k:=i+1 to n-1 do
    begin
      S:=0;
      for j:=0 to i-1 do
        S:=S+C[i,j]*B[j,k];

      B[i,k]:=(A[i,k]-S)/C[i,i]
    end;

  end;

  for i:=1 to n-1 do
  begin
    S:=0;
    for j:=0 to i-1 do
      S:=S+C[i,j]*Y[j];
      try
        Y[i]:=(D[i]-S)/C[i,i];
      except
      on EZeroDivide do
      begin
        ShowMessage('�� ���� ����� �����!!! ������ ������� �� ����!!! ');
        Exit;
      end;
      on EInvalidOp do
      begin
        ShowMessage('�� ���� ����� �����!!! ������ �� ����� �������!!!');
        Exit;
      end;
      end;
  end;

    X[n-1]:=Y[n-1];

  for i:= 0 to n-1 do
  begin
    S:= 0;
    for j:=n-i+1-1 to n-1 do

      S:=S+B[n-1-i,j]*X[j];
      X[n-1-i]:=Y[n-1-i]-S;
  end;
  Result:=X;
end;

procedure TForm1.StringGridConstructor(var sg: TStringGrid; var rowcol: integer;
  var Layout: TLayout);
begin
  sg := TStringGrid.Create(Layout);
  sg.Parent := Layout;
    sg.TextSettings.Font.Size := 14;
    sg.TextSettings.Font.Style := [TFontStyle.fsBold];
    sg.BringToFront;
    sg.Align := TAlignLayout.Client;
    sg.Visible := true;
    sg.RowCount := rowcol;
end;



procedure TForm1.Button1Click(Sender: TObject);
var i,j:integer;  temp:string;
begin

    Memo1.Lines.Clear;
    n1:=matrix_size;

    //   ������������� ���������
      Setlength(a,n1);

    for i:=0 to n1-1 do
    begin
      Setlength(a[i],n1);
    end;

      Setlength(d,n1);
      Setlength(x,n1);


     for i:=0 to n1-1 do
     begin
        for j:=0 to n1-1 do
        begin
          try
            a[i,j]:=strtofloat(Form1.MyStringGrid.Cells[j,i]);
          except on EConvertError do
          begin
            ShowMessage('������� ��������� ������� ������� '+'['+IntToStr(i)+','+IntToStr(j)+']');
            Exit;
          end;
          end;
        end;
    end;

    for j:=0 to n1-1 do
    begin
      try
        d[j]:=strtofloat(Form1.MyStringGrid.Cells[n1,j]);
      except on EConvertError do
      begin
        ShowMessage('������� ��������� ������ ������� '+'['+IntToStr(j)+']');
        Exit;
      end;
      end;
    end;
  //----------------------------------------------------

    X:=Gauss(n1,A,D);

    Memo1.Lines.Add('�������: ');
    Memo1.Lines.Add('=====================');

    for i:=0 to n1-1 do
    begin
        Memo1.Lines.Add(temp);
        temp:='';
        for j:=0 to n1-1 do
        begin
          temp:=temp+A[i,j].ToString+'  ';
        end;
    end;

    Memo1.Lines.Add(temp);
    temp:='';
    Memo1.Lines.Add('');
    Memo1.Lines.Add('������: ');
    Memo1.Lines.Add('=====================');
    Memo1.Lines.Add('');

    for i:=0 to n1-1 do
    begin
      temp:=temp+D[i].ToString+'  ';
    end;

    Memo1.Lines.Add(temp);

    Memo1.Lines.Add('');
    Memo1.Lines.Add('����� ������� ���������: ');
    Memo1.Lines.Add('=====================');

   for i:=0 to n1-1 do
   begin
     Application.ProcessMessages;
     sleep(300);
     Memo1.Lines.Add('X['+IntToStr(i+1)+']='+FloatToStrf(X[i],ffgeneral,6,6));
   end;

//   ������������ ������ (������� ��������)
   a:=nil;
   d:=nil;
   x:=nil;

end;

procedure TForm1.Button2Click(Sender: TObject);

begin
    stringcolumn:=nil;

     InputQuery('������� ������ ����� �������', ['����������� �������'], ['2'],

    procedure(const AResult: TModalResult; const AValues: array of string)
    var i:integer;
      begin
        case AResult of

          mrOk:
          begin
            try
             elementscol:=integer.Parse(AValues[0]);
             SetLength(stringcolumn,elementscol+1);
             matrix_size:=elementscol;
            except on EConvertError do
            begin
              ShowMessage('�������� �������� ����� �����!!!');
              Button1.Enabled:=false;
              Exit;
            end;
            end;

          // ������� ����
          try
            MyStringGrid.Destroy;
            MyStringGrid.Free;
            MyStringGrid:=nil;
          except on EAccessViolation do
          begin

          end;
          end;
          // ������ ���� ������
          StringGridConstructor(MyStringGrid,elementscol,Layout1);

          // ��������� �������
          for i:=0 to Length(stringcolumn)-1 do
          begin
             stringcolumn[i]:=TStringColumn.Create(MyStringGrid);
             stringcolumn[i].Parent:=MyStringGrid;
             stringcolumn[i].Visible:=true;
             stringcolumn[i].Name:='StringColumn'+i.ToString;
             stringcolumn[i].Header:='a['+(i+1).ToString+']';
             if i=Length(stringcolumn)-1 then stringcolumn[i].Header:='d';
          end;

          Button1.Enabled:=true;

          end;

          mrCancel:
          begin
           Button1.Enabled:=false;
           Exit;
          end;
        end;
      end
    );


end;



procedure TForm1.FormDestroy(Sender: TObject);
begin
  stringcolumn:=nil;
  MyStringGrid:=nil;
end;



procedure TForm1.FormShow(Sender: TObject);
begin
  elementscol:=0;
  // ������� StringGrid
  StringGridConstructor(MyStringGrid,elementscol,Layout1);
  Button1.Enabled:=false;
end;

end.
