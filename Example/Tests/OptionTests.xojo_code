#tag Class
Protected Class OptionTests
Inherits TestGroup
	#tag Method, Flags = &h0
		Sub AllowedAndDisallowedTest()
		  // Makes sure that we can't add the same value as both allowed and disallowed
		  
		  dim o as new Option("a", "", "")
		  
		  #pragma BreakOnExceptions false
		  try
		    o.AddAllowedValue("a", "b")
		    o.AddDisallowedValue("b", "c")
		    Assert.Fail("Values allowed and disallowed")
		  catch err as OptionParserException
		    Assert.Pass("Cannot allow and disallow values in the same option")
		  end try
		  #pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AllowedValueTest()
		  dim o as new Option("a", "", "")
		  o.AddAllowedValue("a", "b")
		  dim parser as new OptionParser
		  parser.AddOption o
		  
		  #pragma BreakOnExceptions false
		  try
		    parser.Parse "-a a"
		    Assert.Pass("Allowed value allowed")
		  catch err as OptionParserException
		    Assert.Fail("Allowed value was not allowed")
		  end try
		  
		  try
		    parser.Parse "-a z"
		    Assert.Fail("Value not on allowed list was allowed")
		  catch err as OptionParserException
		    Assert.Pass("Value not on allowed list not allowed")
		  end try
		  #pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ArrayTest()
		  Dim o As New Option("a", "array", "Array of Integers", Option.OptionType.Integer)
		  o.IsArray = True
		  dim parser as new OptionParser
		  parser.AddOption o
		  
		  parser.Parse "-a 1 -a 5 -a 1029"
		  
		  Dim v() As Variant = parser.OptionValue("a").Value
		  Assert.AreEqual(1, v(0).IntegerValue)
		  Assert.AreEqual(5, v(1).IntegerValue)
		  Assert.AreEqual(1029, v(2).IntegerValue)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BasicOptionTest()
		  Dim o As Option
		  
		  o = New Option("a", "apple", "Display an apple", Option.OptionType.Boolean)
		  Assert.AreEqual("a", o.ShortKey)
		  Assert.AreEqual("apple", o.LongKey)
		  Assert.AreEqual("Display an apple", o.Description)
		  Assert.IsTrue(Option.OptionType.Boolean = o.Type, "default option type is Boolean")
		  Assert.AreEqual("BOOL", o.TypeString)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub BooleanHandleValueTest()
		  Dim o As Option
		  
		  o = New Option("t", "test", "Unit Testing", Option.OptionType.Boolean)
		  dim parser as new OptionParser
		  parser.AddOption o
		  
		  parser.Parse "-t=Yes"
		  Assert.IsTrue(parser.BooleanValue("t"), "Yes")
		  
		  parser.Parse "-t=YES"
		  Assert.IsTrue(parser.BooleanValue("t"), "YES")
		  
		  parser.Parse "-t=y"
		  Assert.IsTrue(parser.BooleanValue("t"), "y")
		  
		  parser.Parse "-t=1"
		  Assert.IsTrue(parser.BooleanValue("t"), "1")
		  
		  parser.Parse "-t=on"
		  Assert.IsTrue(parser.BooleanValue("t"), "on")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DisallowedValueTest()
		  dim o as new Option("a", "", "")
		  o.AddDisallowedValue("a", "b")
		  dim parser as new OptionParser
		  parser.AddOption o
		  
		  #pragma BreakOnExceptions false
		  try
		    parser.Parse "-a=a"
		    Assert.Fail("Disallowed value allowed")
		  catch err as OptionParserException
		    Assert.Pass("Disallowed value was not allowed")
		  end try
		  
		  try
		    parser.Parse "-a=z"
		    Assert.Pass("Value not on disallowed list was allowed")
		  catch err as OptionParserException
		    Assert.Fail("Value not on disallowed list not allowed")
		  end try
		  #pragma BreakOnExceptions default
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub IntegerHandleValueTest()
		  Dim o As New Option("t", "test", "Unit Testing", Option.OptionType.Integer)
		  dim parser as new OptionParser
		  parser.AddOption o
		  
		  parser.Parse "-t="
		  Assert.IsTrue(parser.IntegerValue("t") = 0)
		  
		  parser.Parse "-t=1"
		  Assert.IsTrue(parser.IntegerValue("t") = 1)
		  
		  parser.Parse "-t 10293"
		  Assert.IsTrue(parser.IntegerValue("t") = 10293)
		  
		End Sub
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="FailedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="IncludeGroup"
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="PassedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RunTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SkippedTestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TestCount"
			Group="Behavior"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
